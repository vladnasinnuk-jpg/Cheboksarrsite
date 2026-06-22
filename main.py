from flask import Flask, request, jsonify
from flask_cors import CORS
from datetime import datetime
import pymysql

def get_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='7452',
        database='hr_department_site',
        cursorclass=pymysql.cursors.DictCursor
    )

app = Flask(__name__)
CORS(app)
@app.route("/Authorization", methods=['POST'])
def authorization():
    data = request.get_json()

    login = data.get('login')
    password = data.get('password')

    user_info = []
    user_documents = []
    content = []

    connection = get_connection()

    try:
        with connection.cursor() as cursor:
            sql_1 = """
            SELECT 
            	users.id,
                users.login,
                users.password,
                users.first_name,
                users.second_name,
                users.photo,
                roles.name AS role,
                COALESCE(employees.age, hr.age) AS age,
                COALESCE(employees.phone, hr.phone) AS phone,
                COALESCE(employees.birth_date, hr.birth_date) AS birth_date,
                COALESCE(employees.address, hr.address) AS address,
                COALESCE(employees.status, hr.status) AS status,
                COALESCE(employees.email, hr.email) AS email,
                COALESCE(employees.salary, hr.salary) AS salary,
                COALESCE(employees.hire_date, hr.hire_date) AS hire_date,
                employees.position,
                hr.department,
                documents.file_name,
                documents.description,
                documents.uploaded_at
            FROM users 
            JOIN roles ON users.roles_id = roles.id
            LEFT JOIN employees  ON users.id = employees.user_id
            LEFT JOIN hr  ON users.id = hr.user_id
            left join documents on users.id = documents.user_id 
            WHERE users.login = %s AND users.password = %s
            """
            cursor.execute(sql_1, (login, password))
            Data = cursor.fetchall()
            for i in Data:
                user_documents.append({
                    "file_name" : i["file_name"],
                    "description" : i["description"],
                    "uploaded_at" : i["uploaded_at"]
                })
            if Data:
                sql_2 = """
                select *
                from content
                """
                cursor.execute(sql_2)
                content = cursor.fetchall()

                user_info = dict(list(Data[0].items())[:-3])

                if user_info["birth_date"]:
                    user_info["birth_date"] = user_info["birth_date"].strftime("%Y-%m-%d")
                if user_info["hire_date"]:
                    user_info["hire_date"] = user_info["hire_date"].strftime("%Y-%m-%d")
                for doc in user_documents:
                    if doc["uploaded_at"]:
                        doc["uploaded_at"] = doc["uploaded_at"].strftime("%Y-%m-%d %H:%M")
                for cont in content:
                    if cont["published"]:
                        cont["published"] = cont["published"].strftime("%Y-%m-%d %H:%M")

                    return jsonify({
                        "success": True,
                        "user_info": user_info,
                        "documents": user_documents,
                        "content": content,
                    })
            else:
                return jsonify({
                    "success": False
                })
    finally:
        connection.close()
@app.route("/Registration", methods=["POST"])
def registration():
    print("registration")
    data = request.get_json()

    login = data.get('login')
    password = data.get('password')
    first_name = data.get('first_name')
    second_name = data.get('second_name')

    connection = get_connection()

    try:
        with connection.cursor() as cursor:
            sql_1 = """
            select login
            from users
            where login = %s;
            """
            cursor.execute(sql_1, (login,))
            user = cursor.fetchone()
            if user:
                return jsonify({
                    "success": False
                })
            else:
                sql_2 = """
                INSERT INTO users ( password , first_name , second_name, roles_id, login)
                VALUES (%s, %s,%s, 1,%s);
                """
                cursor.execute(sql_2, (password,first_name,second_name,login,))
                sql_2 = """
                select *
                from content
                """
                cursor.execute(sql_2)

                connection.commit()
                return jsonify({
                    "success": True,
                    "content": cursor.fetchall()
                })
    finally:
        connection.close()
@app.route("/update_profile", methods=["POST"])
def update():
    ServerData = request.get_json()
    data = ServerData.get('data')
    login = ServerData.get('login')
    password = ServerData.get('password')
    connection = get_connection()

    with connection.cursor() as cursor:
        sql = """
        select name as role, users.id
        from users
        join roles on users.roles_id = roles.id
        WHERE users.login = %s AND users.password = %s
        """
        cursor.execute(sql, (login,password))
        user = cursor.fetchone()
        role = user["role"]
        id = user["id"]
        if role == "visitor":
            sql = """
            update users SET first_name = %s , second_name = %s
            WHERE users.id = %s
            """
            cursor.execute(sql, (data.get('first_name'), data.get('second_name'),id))
        elif role == "employees":
            sql = """
            UPDATE users
            JOIN employees ON users.id = employees.user_id
            SET 
            first_name = %s, 
            second_name = %s,
            age = %s,
            phone = %s,
            birth_date = %s,
            address = %s,
            status = %s,
            email = %s
            WHERE users.id = %s;
            """
            cursor.execute(sql, (data.get('first_name'),data.get('second_name'),
                data.get('age'),data.get('phone'),data.get('birth_date'),
                data.get('address'),data.get('status'),data.get('email'),id))
        else:
            sql = """
            UPDATE users
            JOIN hr ON users.id = hr.user_id
            SET 
            	first_name = %s, 
            	second_name = %s,
            	age = %s,
            	phone = %s,
            	birth_date = %s,
            	department = %s,
            	address = %s,
            	status = %s,
            	email = %s
            WHERE users.id = %s;
            """
            cursor.execute(sql, (data.get('first_name'), data.get('second_name'),
                data.get('age'), data.get('phone'),data.get('birth_date'), data.get('departament'),
                data.get('address'),data.get('status'), data.get('email'), id))
        connection.commit()
    connection.close()
    return jsonify({
        "success": True
    })
@app.route("/get_users", methods=["POST"])
def get_users():
    ServerData = request.get_json()
    offset_users = ServerData.get('offset_users')
    connection = get_connection()
    with connection.cursor() as cursor:
        sql = """
        select id,first_name,second_name,photo
        from users
        LIMIT 100 OFFSET %s
        """
        cursor.execute(sql,offset_users)
        userS = cursor.fetchall()
    connection.close()
    return jsonify({
        "userS": userS
    })
@app.route("/get_user", methods=["POST"])
def get_user():
    data = request.get_json()
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            sql_1 = """
            SELECT 
                users.id,
                users.first_name,
                users.second_name,
                users.photo,
                roles.name as role,
                COALESCE(employees.age, hr.age) AS age,
                COALESCE(employees.phone, hr.phone) AS phone,
                COALESCE(employees.birth_date, hr.birth_date) AS birth_date,
                COALESCE(employees.address, hr.address) AS address,
                COALESCE(employees.status, hr.status) AS status,
                COALESCE(employees.email, hr.email) AS email,
                COALESCE(employees.salary, hr.salary) AS salary,
                COALESCE(employees.hire_date, hr.hire_date) AS hire_date
            FROM users 
            LEFT JOIN employees  ON users.id = employees.user_id
            LEFT JOIN hr ON users.id = hr.user_id
            LEFT JOIN roles ON users.roles_id = roles.id
            WHERE users.id = %s
            """
            cursor.execute(sql_1, (data.get('id'),))
            user_info = cursor.fetchone()
            if not user_info:
                return jsonify({
                    "success": False
                })
            if user_info["birth_date"]:
                user_info["birth_date"] = user_info["birth_date"].strftime("%Y-%m-%d")
            if user_info["hire_date"]:
                user_info["hire_date"] = user_info["hire_date"].strftime("%Y-%m-%d")

            return jsonify({
                "success": True,
                "user_info":user_info
            })
    finally:
        connection.close()
@app.route("/get_users_with_parameters", methods=["POST"])
def get_users_with_parameters():
    data = request.get_json()["data"]
    offset_users = request.get_json()["offset_users"]
    sql = """
    SELECT
    	users.id,
        users.first_name,
        users.second_name,
        users.photo,
        users.roles_id
    FROM users
    LEFT JOIN employees ON users.id = employees.user_id
    LEFT JOIN hr ON users.id = hr.user_id
    LEFT JOIN roles ON roles.id = users.roles_id
    """
    conditions = []
    values = []
    # Ім'я
    if data["first_name-filter"]:
        conditions.append("users.first_name LIKE %s")
        values.append(f"%{data['first_name-filter']}%")
    # Прізвище
    if data["second_name-filter"]:
        conditions.append("users.second_name LIKE %s")
        values.append(f"%{data['second_name-filter']}%")
    # Вік
    if data["age-filter"]:
        conditions.append("COALESCE(employees.age, hr.age) LIKE %s")
        values.append(f"%{data['age-filter']}%")
    # Телефон
    if data["phone-filter"]:
        conditions.append("COALESCE(employees.phone, hr.phone) LIKE %s")
        values.append(f"%{data['phone-filter']}%")

    # Зарплата
    if data["salary-filter"]:
        conditions.append("COALESCE(employees.salary, hr.salary) LIKE %s")
        values.append(f"%{data['salary-filter']}%")

    # Статус
    if data["status-filter"]:
        conditions.append("COALESCE(employees.status, hr.status) LIKE %s")
        values.append(f"%{data['status-filter']}%")

    # Якщо є хоча б один фільтр
    if conditions:
        sql += " WHERE "
        sql += " AND ".join(conditions)
    sql += "LIMIT 100 OFFSET %s"
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql, (values,offset_users))
        return jsonify({
            "userS": cursor.fetchall()
        })
    finally:
        connection.close()
@app.route("/get_chats", methods=["POST"])
def get_chats():
    user_id = request.get_json().get('id')
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            sql = """
            select users.id,users.first_name,users.second_name,users.photo,temp.chat_id
            from users 
            join (
            	select first_user_id as id, id as chat_id
            	from chats
            	where chats.second_user_id = %s
            	union
            	select second_user_id,id
            	from chats
            	where chats.first_user_id = %s
            ) as temp on temp.id = users.id
            """
            cursor.execute(sql, (user_id,user_id,))
        return jsonify({
            "chats": cursor.fetchall()
        })
    finally:
        connection.close()
@app.route("/get_messages", methods=["POST"])
def get_messages():
    data = request.get_json()
    chat_id = data.get('chat_id')
    offset = data.get('offset_messages')
    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            sql = """
            select *
            from messages
            where chat_id = %s
            order by messages.created_at desc
            limit 100 offset %s
            """
            cursor.execute(sql, (chat_id,offset))
            messages = cursor.fetchall()
            for msg in messages:
                if msg.get("created_at"):
                    msg["created_at"] = msg["created_at"].strftime("%H:%M:%S")
            return jsonify({
                "messages": messages
            })
    finally:
        connection.close()
@app.route("/write_message", methods=["POST"])
def write_message():
    data = request.get_json()

    message = data.get('message')
    chat_id = data.get('chat_id')
    date = data.get('date')
    newDate = datetime.fromisoformat(date.replace("Z", "+00:00"))
    sender_id = data.get('sender_id')

    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            sql = """
            INSERT INTO messages (chat_id,sender_id, text, created_at) 
            VALUES (%s, %s, %s, %s);
            """
            cursor.execute(sql, (chat_id,sender_id,message,newDate))
            connection.commit()
            return jsonify({
                "success": True
            })
    finally:
        connection.close()
@app.route("/find_or_create_chat", methods=["POST"])
def find_or_create_chat():
    data = request.get_json()

    id = data.get('id')
    current_user = data.get('current_user')

    connection = get_connection()
    try:
        with connection.cursor() as cursor:
            sql = """
            select *    
            from chats
            where (chats.first_user_id = %s and chats.second_user_id = %s) or
            	  (chats.first_user_id = %s and chats.second_user_id = %s)
            """
            cursor.execute(sql, (id, current_user,current_user, id))
            chat = cursor.fetchone()
            if chat:
                return jsonify({
                    "chat": chat
                })
            sql = """
            INSERT INTO chats (first_user_id, second_user_id)
		    VALUES (%s,%s)
            """
            cursor.execute(sql, (id, current_user))
            connection.commit()

            return jsonify({
                "chat": cursor.lastrowid
            })
    finally:
        connection.close()
app.run(port=5000,debug=True)
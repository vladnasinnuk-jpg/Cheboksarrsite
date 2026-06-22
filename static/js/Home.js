import { getData, saveData } from "./Save_and_get_info.js";


let user = getData("user_info");
let documents = getData("documents");
let content = getData("content");
let input1 = document.querySelector('.first_name-filter');
let input2 = document.getElementsByClassName('find-user-input')[0];
let chats = getData("chats");
let current_chat = null;
function renderContent() {

    let code = "";
    for (let i = 0; i < content.length; i++) {
        code += `
            <div class="content">
                <h2 class="post-topic">${content[i].topic}</h3>
                <img src="/static/pictures/${content[i].img_url}" class="content-img">
                <p class="content-text">${content[i].text}</p>
                <h3 class="content-publicated"> опубліковано: ${content[i].published}</h3>
                </div>
        `;
    }
    document.getElementById("app").innerHTML = code;
}
function Submit(FORM){
    const newFormData = new FormData(FORM);
    const Data = Object.fromEntries(newFormData.entries());
    fetch("/static/js/update_profile", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            data: Data,
            login: user.login,
            password: user.password
        })
    });
    for (let key in Data) {
        user[key] = Data[key];
    }
}
function renderProfile() {
    document.getElementById("app").innerHTML = `
        <form class="profile" autocomplete="off">
            <img src="/static/pictures/${user.photo ? user.photo : "Without-avatar.png"}" class="profile-avatar">
            <div class="profile-information">
                <div class="profile-field">
                    <label for="first_name">Ім'я : </label>
                    <input name="first_name" class="first_name changed" type="text" value="${user.first_name || ''}" autocomplete="off">
                </div>
                <div class="profile-field">
                    <label for="second_name">Призвіще : </label>
                    <input name="second_name" class="second_name changed" type="text" value="${user.second_name || ''}" autocomplete="off">
                </div>
            </div>
            ${user.role != "visitor" ? `
            <div class="profile-information">
                <div class="profile-field">
                    <label for="address">Адреса : </label>
                    <input name="address" class="address changed" type="text" value="${user.address || ''}" autocomplete="off">
                </div>
                <div class="profile-field">
                    <label for="email">Електронна пошта : </label>
                    <input name="email" class="email changed" type="text" value="${user.email || ''}" autocomplete="off">
                </div>
            </div>
            <div class="profile-information">
                <div class="profile-field">
                    <label for="phone">Телефон : </label>
                    <input name="phone" class="phone changed" type="text" value="${user.phone || ''}" autocomplete="off">
                </div>
                <div class="profile-field">
                    <label for="birth_date">День народження : </label>
                    <input name="birth_date" class="birth_date changed" type="text" value="${user.birth_date || ''}" autocomplete="off">
                </div>
            </div>
            <div class="profile-information">
                <div class="profile-field">
                    <label for="age">Років : </label>
                    <input name="age" class="age changed" type="text" value="${user.age || ''}" autocomplete="off">
                </div>
                <div class="profile-field">
                    <label for="status">Статус : </label>
                    <input name="status" class="status changed" type="text" value="${user.status || ''}" autocomplete="off">
                </div>
            </div>
            <div class="profile-information">
                <div class="profile-field">
                    <label for="salary">Зарплата : </label>
                    <input name="salary" class="salary" type="text" value="${user.salary || ''}" autocomplete="off" disabled>
                </div>
                <div class="profile-field">
                    <label for="hire_date">День працевлаштування : </label>
                    <input name="hire_date" class="hire_date" type="text" value="${user.hire_date || ''}" autocomplete="off" disabled>
                </div>
            </div>
            <div class="profile-information">
                ${user.role == "employees" ?  `
                <div class="profile-field">
                    <label for="position">Позиція : </label>
                    <input name="position" class="position changed" type="text" value="${user.position || ''}" autocomplete="off" >
                </div>
                    ` : `
                <div class="profile-field">
                    <label for="departament">Департамент : </label>
                    <input name="departament" class="department changed" type="text" value="${user.departament || ''}" autocomplete="off">
                </div>
                    `}
            </div>
                ` : ""}
        </form>
        <div class="profile-buttons">
            <button type="button" class="submit" name="submit">Підтвердити</button>
            <button type="button" class="reject" name="reject">Відхилити</button>
        </div>
    `;
    const FORM = document.getElementsByClassName("profile")[0];
    
    document.querySelector(".submit").onclick = () => Submit(FORM);
    document.querySelector(".reject").onclick = renderProfile;
}
function renderDocuments(){
    let code = "";
    if (documents[0].file_name != null){
        for (let i = 0; i < documents.length; i++) {
            code += `
                <div class="document">
                    <img src="/static/pictures/${documents[i].file_name}" class="document-img">
                    <p class="document-description">${documents[i].description}</p>
                    <h3 class="document-uploaded"> опубліковано: ${documents[i].uploaded_at}</h3>
                </div>
            `;
        }
    }
    document.getElementById("app").innerHTML = `<div class="All-documents">${code}</div>`;
}
function show_users(AllUsers, offset_users){
    let code = "";
    for (let i = offset_users - 100; i < AllUsers.length; i++) {
        code += `
            <div class="show-user" id="${AllUsers[i].id}">
                <img src="/static/pictures/${AllUsers[i].photo || "Without-avatar.png"}" class="user-avatar">
                <div class="name-and-sername">
                    <p class="user-name">  Ім'я :  ${AllUsers[i].first_name}</p>
                    <p class="user-srename">  Прізвище : ${AllUsers[i].second_name}</p>
                </div>
            </div>
        `;
    }
    return code;
}
function show_user_info(current_user){
    let code = `
    <form class="profile" autocomplete="off">
        <img src="/static/pictures/${current_user.photo ? current_user.photo : "Without-avatar.png"}" class="profile-avatar">
        <div class="profile-information">
            <div class="profile-field">
                <label for="first_name">Ім'я : </label>
                <input name="first_name" class="first_name changed" type="text" value="${current_user.first_name || ''}" autocomplete="off">
            </div>
            <div class="profile-field">
                <label for="second_name">Призвіще : </label>
                <input name="second_name" class="second_name changed" type="text" value="${current_user.second_name || ''}" autocomplete="off">
            </div>
        </div>
        ${current_user.role != "visitor" ? `
        <div class="profile-information">
            <div class="profile-field">
                <label for="address">Адреса : </label>
                <input name="address" class="address changed" type="text" value="${current_user.address || ''}" autocomplete="off">
            </div>
            <div class="profile-field">
                <label for="email">Електронна пошта : </label>
                <input name="email" class="email changed" type="text" value="${current_user.email || ''}" autocomplete="off">
            </div>
        </div>
        <div class="profile-information">
            <div class="profile-field">
                <label for="phone">Телефон : </label>
                <input name="phone" class="phone changed" type="text" value="${current_user.phone || ''}" autocomplete="off">
            </div>
            <div class="profile-field">
                <label for="birth_date">День народження : </label>
                <input name="birth_date" class="birth_date changed" type="text" value="${current_user.birth_date || ''}" autocomplete="off">
            </div>
        </div>
        <div class="profile-information">
            <div class="profile-field">
                <label for="age">Років : </label>
                <input name="age" class="age changed" type="text" value="${current_user.age || ''}" autocomplete="off">
            </div>
            <div class="profile-field">
                <label for="status">Статус : </label>
                <input name="status" class="status changed" type="text" value="${current_user.status || ''}" autocomplete="off">
            </div>
        </div>
        <div class="profile-information">
            <div class="profile-field">
                <label for="salary">Зарплата : </label>
                <input name="salary" class="salary" type="text" value="${current_user.salary || ''}" autocomplete="off" disabled>
            </div>
            <div class="profile-field">
                <label for="hire_date">День працевлаштування : </label>
                <input name="hire_date" class="hire_date" type="text" value="${current_user.hire_date || ''}" autocomplete="off" disabled>
            </div>
        </div>` : ""}
    </form>
    <button class="write-user">Написати</button>`;
    document.getElementById("app").innerHTML = code;
    document.querySelector(".write-user").onclick = () => {
        fetch("/static/js/find_or_create_chat", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                id: user.id,
                current_user: current_user.id
            })
        })
        .then(res => res.json())
        .then(data => {
            renderChats(data.chat.id);
        });
    };
}
function renderFindUsers(IsParameters){
    let AllUsers = [];
    let offset_users = 0;
    let counter = 0;
    let isLoading = false;
    let app = document.querySelector("#app");  app.innerHTML = `<div class="All-users"></div>`;
    const container = app.children[0];

    !IsParameters ? findUsers() : findUsers_With_Parameters();
    

    container.addEventListener("scroll", () => {
        if(container.scrollTop + container.clientHeight >= container.scrollHeight - 300 && !isLoading){
            !IsParameters ? findUsers() : findUsers_With_Parameters();
        };
    });
    container.addEventListener('click', function(event) {
        let target = event.target;
        while (target && !target.classList.contains('show-user')) {
            target = target.parentElement;
        }
        if (target && target.classList.contains('show-user')) {
            fetch("/static/js/get_user", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    id: target.id
                })
            })
            .then(res => res.json())
            .then(data => { if(data.success){ show_user_info(data.user_info); } })
            .catch(err => console.error("Ошибка загрузки:", err));
        }
    });

    function findUsers(){
        isLoading = true;
        console.log(AllUsers);
        fetch("/static/js/get_users", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                offset_users: offset_users
            })
        })
        .then(res => res.json())
        .then(data => {
            AllUsers = [...AllUsers, ...data.userS];
            offset_users += 100;
            document.getElementsByClassName("All-users")[0].innerHTML += show_users(AllUsers, offset_users);
            
        })
        .catch(err => console.error("Ошибка загрузки:", err))
        .finally(() => {
            isLoading = false;
        });
    }
    function findUsers_With_Parameters(){
        isLoading = true;
        let FORM = document.querySelector(".find-window");
        const formData = new FormData(FORM);
        const Data = Object.fromEntries(formData.entries());
        fetch("/static/js/get_users_with_parameters", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                offset_users: offset_users,
                data: Data,
            })
        })
        .then(res => res.json())
        .then(data => {
            AllUsers = [...AllUsers, ...data.userS];
            offset_users += 100;
            document.getElementsByClassName("All-users")[0].innerHTML += show_users(AllUsers, offset_users);
        })
        .catch(err => console.error("Ошибка загрузки:", err))
        .finally(() => {
            isLoading = false;
        });
    }
}
function renderChats(OpenChat){
    let offset_messages = 0;
    let messages_arr = [];
    let last_chat_id = -1;
    let isLoading = false;

    fetch("/static/js/get_chats", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            id: user.id
        })
    })
    .then(res => res.json())
    .then(data => {
        saveData("chats", data.chats);
        chats = getData("chats");
        let code = "";
        for (let i = 0; i < chats.length; i++) {
            code += `
                <div class="chat" id="${chats[i].chat_id}">
                    <img src="/static/pictures/${chats[i].photo || "Without-avatar.png"}" class="avatar-in-chat">
                    <p class="user-name-and-sername"> ${chats[i].first_name} ${chats[i].second_name}</p>
                </div>
            `
        }
        document.getElementById("app").innerHTML =  `
            <div class="chats_and_current-chat">
                <div class="curren-chat">
                    <div class="messageS"></div>
                    <div class="wruper-message">
                        <input type="text" class="message-input" name="message-input" placeholder="Написати повідомлення...">
                        <button class="send-message">>></button>
                    </div>
                </div>
                <div class="Allchats">
                    ${code}
                </div>
            <div>
            `;
        document.getElementsByClassName("Allchats")[0].addEventListener('click', function(event) {
            let target = event.target;
            console.log(target);
            while (target && !target.classList.contains('chat')) {
                target = target.parentElement;
            }
            if (target && target.classList.contains('chat') && last_chat_id != target.id) {
                last_chat_id = -1;
                renderMessages(target.id);
            }
        });
        if(OpenChat != -1){
            renderMessages(OpenChat);
        }
    })
    .catch(err => console.error("Ошибка загрузки:", err));


    function renderMessages(chat_id){
        isLoading = true;
        document.getElementsByClassName("wruper-message")[0].style.display = "flex";
        let massages_container = document.getElementsByClassName("messageS")[0];
        let new_chat = false;


        if(last_chat_id != chat_id){
            new_chat = true;
            last_chat_id = chat_id;
            messages_arr = [];
            offset_messages = 0;

            document.getElementsByClassName("send-message")[0].onclick = () => {
                let now = new Date();
                let Your_massage = document.getElementsByClassName("message-input")[0];
                massages_container.innerHTML += `
                    <div class="message my-message" "style = 'align-items: flex-start'>
                        <div class="border">
                            <p class="message-text">${Your_massage.value}</p>
                            <p class="message-time">${now.getHours()}:${now.getMinutes()}:${now.getSeconds()}</p>
                        </div>
                    </div>`

                fetch("/static/js/write_message", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        message: Your_massage.value,
                        chat_id: chat_id,
                        date: now,
                        sender_id: user.id
                    })
                })
                massages_container.scrollTop = massages_container.scrollHeight
                Your_massage.value = "";
            };
        }
        console.log(chat_id);
        console.log(offset_messages);
        fetch("/static/js/get_messages", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                chat_id: chat_id,
                offset_messages: offset_messages
            })
        })
        .then(res => res.json())
        .then(data => {
            messages_arr = [ ...messages_arr,...data.messages];
            console.log(messages_arr);
            let code = "";

            for (let i = offset_messages; i < messages_arr.length; i++) {
                console.log(messages_arr[i].sender_id == user.id);
                code = `
                    <div class="message ${messages_arr[i].sender_id == user.id ? "my-message" : null}">
                        <div class="border">
                            <p class="message-text">${messages_arr[i].text}</p>
                            <p class="message-time">${messages_arr[i].created_at}</p>
                        </div>
                    </div>
                    ` + code;
            }

            new_chat ? massages_container.innerHTML = code : massages_container.innerHTML = code + massages_container.innerHTML;

            setTimeout(() => {
                new_chat ? massages_container.scrollTop = massages_container.scrollHeight : null;
            }, 5);

            if (new_chat) {
                massages_container.onscroll = () => {
                    if(massages_container.scrollTop <= 300 && !isLoading && offset_messages == messages_arr.length){
                        renderMessages(chat_id);
                    };
                };
            }
        })
        .catch(err => console.error("Ошибка загрузки:", err))
        .finally(() => {
            offset_messages += 100;
            isLoading = false;
        });
    }
}


input1.addEventListener('input', (e) => { input2.value = e.target.value; });
input2.addEventListener('input', (e) => { input1.value = e.target.value; });

document.getElementsByClassName("name-in-header")[0].textContent = user.first_name + " " + user.second_name;
document.getElementsByClassName("avatar-in-header")[0].src = user.photo ? `pictures/${user.photo}` : "pictures/Without-avatar.png"
document.getElementsByClassName("filter-user-button")[0].addEventListener('click', () => {
    document.getElementsByClassName("find-window")[0].classList.toggle('active');
});
document.getElementsByClassName("stettings-ikon")[0].addEventListener('click', () => {
    document.getElementsByClassName("stettings-window")[0].classList.toggle('active-settings');
});
renderContent();
let children = document.getElementsByClassName("navigation")[0].children;
document.getElementById("button-to-information").onclick = renderContent;
document.getElementById("button-to-profile").onclick = renderProfile;
document.getElementById("button-to-documents").onclick = renderDocuments;
document.getElementById("button-to-find-users").onclick = () => {renderFindUsers(false);};
document.querySelector(".find-user-button").onclick = () => {renderFindUsers(true) };
document.getElementById("button-to-chats").onclick = () => renderChats(-1);
const themeRadios = document.querySelectorAll('input[name="theme"]');

themeRadios.forEach(radio => {
    radio.addEventListener('change', (event) => {
        const selectedTheme = event.target.value;
        let logo = document.getElementsByClassName('logo')[0];
        if (selectedTheme === 'dark') {
            document.documentElement.setAttribute('data-theme', 'dark');
            logo.src = "pictures/white-logo.png";
        } else {
            document.documentElement.removeAttribute('data-theme');
            logo.src = "pictures/logo.png";
        }
    });
});
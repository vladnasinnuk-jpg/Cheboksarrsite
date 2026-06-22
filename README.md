# 
# Cheboksarrsite

Веб-приложение для управления кадрами (HR Department Site), написанное на Python с использованием фреймворка Flask.

## 🛠️ Технологии
* Python 3
* Flask
* HTML / CSS / JavaScript
* База данных (дамп прикреплен в репозитории)

## 🚀 Как запустить проект локально

1. **Клонируйте репозиторий или скачайте архив:**
   ```bash
   git clone https://github.com
   cd Cheboksarrsite
   ```

2. **Создайте и активируйте виртуальное окружение:**
   ```bash
   python -m venv venv
   # Для Windows:
   venv\Scripts\activate
   # Для macOS/Linux:
   source venv/bin/activate
   ```

3. **Установите зависимости:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Настройте базу данных:**
   * Восстановите базу данных из файла дампа `dump-hr_department_site...` в вашей СУБД.

5. **Запустите сервер:**
   ```bash
   python main.py
   ```
   После этого сайт будет доступен в браузере по адресу `http://127.0.0`.

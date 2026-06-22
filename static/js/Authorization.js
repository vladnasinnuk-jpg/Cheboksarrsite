import { saveData } from "./Save_and_get_info.js";

const FORM = document.querySelector(".authorization");
let Login = null;
let Password = null;
let First_name = null;
let Second_name = null;
// Це короче коли тип заходить на сайт та йому треба тільки ввести логін і пароль
function AddAuthorizationHtml(){
    FORM.innerHTML = `
            <input class="input-authorization login" type="text" placeholder="   Логін" name="login">
            <input class="input-authorization password" type="password" placeholder="   Пароль" name="password">
            <h3 class="text-for-authorization">Продовжуючи, ви приймаєте правила сервісу та політику конфіденційності.</h3>
            <button type="button" class="button-authorization" name="authorization">Увійти</button>
            <button type="button" class="button-authorization" name="registration">Зареєструватись</button>
            <h3 class="error-message"></h3>
        `;

        const registration_btn = FORM.registration;

        registration_btn.addEventListener("click", (event) => {
            event.preventDefault();
            AddRegistrationHtml();
        });
}
AddAuthorizationHtml();

// Це коли користувач зайшов перший раз і хоче зареєструватись
function AddRegistrationHtml(){
    Login = FORM.login.value;
    Password = FORM.password.value;
    FORM.innerHTML = `
            <input class="input-authorization login" type="text" placeholder="   Логін" name="login">
            <input class="input-authorization password" type="password" placeholder="   Пароль" name="password">
            <input class="input-authorization first_name" type="text" placeholder="   Ім'я" name="first_name">
            <input class="input-authorization second_name" type="text" placeholder="   фамілія" name="second_name">
            <h3 class="text-for-authorization">Продовжуючи, ви приймаєте правила сервісу та політику конфіденційності.</h3>
            <button type="button" class="button-authorization" name="registration">Зареєструватись</button>
            <h3 class="error-message"></h3>
        `;
    FORM.login.value = Login;
    FORM.password.value = Password;

    FORM.registration.onclick = CreateUser;
}


function FindUser(){
    const start = performance.now();
    Login = FORM.login.value;
    Password = FORM.password.value;
    if (FORM.login.value == "" || FORM.password.value == "") {
        document.querySelector(".error-message").textContent = "Всі поля повинні бути заповнені";
    }
    else{
        fetch('/static/js/Authorization', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                login: Login,
                password: Password,
            })
        })
        .then(res => res.json())
        .then(data => {
            if(data.success){
                saveData("user_info",data.user_info);
                saveData("documents",data.documents);
                saveData("content",data.content);

                //console.log(`Выполнено за: ${performance.now() - start} мс`);
                window.location.href = 'Home.html';
            }
            else{
                console.log(`Выполнено за: ${performance.now() - start} мс`);
                document.querySelector(".error-message").textContent = "Неправельний логін або пароль";
            }
        });
    }
}


function CreateUser(){

    Login = FORM.login.value;
    Password = FORM.password.value;
    First_name = FORM.first_name.value;
    Second_name = FORM.second_name.value;

    if (Login == "" || Password == "" || First_name == "" || Second_name == "") {
        document.querySelector(".error-message").textContent = "Всі поля повинні бути заповнені";
    }
    else{
        fetch('/static/js/Registration', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                login: Login,
                password: Password,
                first_name: First_name,
                second_name: Second_name,
                role: "visitor"
            })
        })
        .then(res => res.json())
        .then(data => {
            if(data.success){
                saveData("user_info",{
                    login: Login,
                    password: Password,
                    first_name: First_name,
                    second_name: Second_name
                });
                saveData("documents",[]);
                saveData("content",data.content);
                window.location.href = 'Home.html';
            }
            else{ document.querySelector(".error-message").textContent = "Користувач з таким логіном вже є!"; }
        });
    }
}

FORM.authorization.onclick = FindUser;

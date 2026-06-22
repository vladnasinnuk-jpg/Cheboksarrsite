export function saveData(key, data) {
    sessionStorage.setItem(key, JSON.stringify(data));
}

export function getData(key){
    return JSON.parse(sessionStorage.getItem(key));
}

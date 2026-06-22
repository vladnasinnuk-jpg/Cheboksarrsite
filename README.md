# Cheboksarrsite

这是一个基于 Python 和 Flask 框架开发的人事管理系统（HR Department Site）网站。

## 🛠️ 技术栈
* Python 3
* Flask
* HTML / CSS / JavaScript
* 数据库（项目中已包含数据转储文件 dump）

## 🚀 如何在本地运行本项目

1. **克隆仓库或下载压缩包：**
   ```bash
   git clone https://github.com
   cd Cheboksarrsite
   ```

2. **创建并激活虚拟环境：**
   ```bash
   python -m venv venv
   # Windows 系统：
   venv\Scripts\activate
   # macOS/Linux 系统：
   source venv/bin/activate
   ```

3. **安装依赖项：**
   ```bash
   pip install -r requirements.txt
   ```

4. **配置数据库：**
   * 请将项目中的 `dump-hr_department_site...` 数据库转储文件导入到您的数据库管理系统中。

5. **启动服务器：**
   ```bash
   python main.py
   ```
   启动后，可在浏览器中访问 `http://127.0.0` 查看网站。

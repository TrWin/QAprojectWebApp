from flask import Flask,g,redirect,render_template,request,session,url_for
import cx_Oracle

##login control##
class User:
    def __init__(self, id, username, password):
        self.id = id
        self.username = username
        self.password = password

    def __repr__(self):
        return f'<User: {self.username}>'

users = []
users.append(User(id=1, username='admin', password='12345678'))


app = Flask(__name__)
app.secret_key = 'somesecretkeythatonlyishouldknow'

@app.before_request
def before_request():
    g.user = None

    if 'user_id' in session:
        user = [x for x in users if x.id == session['user_id']][0]
        g.user = user
        

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        session.pop('user_id', None)

        username = request.form['username']
        password = request.form['password']
        
        user = [x for x in users if x.username == username][0]
        if user and user.password == password:
            session['user_id'] = user.id
            return redirect(url_for('profile'))

        return redirect(url_for('login'))

    return render_template('login.html')

@app.route('/profile')
def profile():
    if not g.user:
        return redirect(url_for('login'))

    return render_template('profile.html')

@app.route('/dropsession')
def dropsession():
        session.pop('user',None)
        return redirect(url_for('login'))
##end login control##

conn = cx_Oracle.connect('SYSTEM/Win102541@//localhost:1521/xe')

@app.route("/")
def Showdata():
        cur=conn.cursor()
        cur.execute("select * from qa order by Pattern_code")
        rows = cur.fetchall()
        lengh = len(rows)
        conn.commit()
        return render_template('index.html',datas=rows)

@app.route("/add")
def showForm():
        return render_template('adddata.html')

@app.route("/insert",methods=['POST'])
def insert():
        test=['0','0','0','0','0','0']
        if request.method=="POST":
                test[0]=request.form['pc']
                test[1]=request.form['pn']
                test[2]=request.form['sqlcode']
                test[3]=request.form['system']
                test[4]=request.form['confident']
                test[5]=request.form['doc']
                with conn.cursor() as cursor:
                        cursor.execute("insert into QA(Pattern_code,Pattern_name,Sql_code,System_Detail,Confidentscore,Doc) values(:0,:1,:2,:3,:4,:5)",(test[0],test[1],test[2],test[3],test[4],test[5]))
                        conn.commit()
                return redirect(url_for('Showdata'))

@app.route("/update",methods=['POST'])
def update():
        test=['0','0','0','0','0','0']
        if request.method=="POST":
                test[0]=request.form['pc']
                test[1]=request.form['pn']
                test[2]=request.form['sqlcode']
                test[3]=request.form['system']
                test[4]=request.form['confident']
                test[5]=request.form['doc']
                with conn.cursor() as cursor:
                        cursor.execute("update qa set Pattern_code=:0 ,Pattern_name=:1 ,Sql_code=:2 ,System_Detail=:3 ,Confidentscore=:4 ,Doc=:5 where Pattern_code=:0",(test[0],test[1],test[2],test[3],test[4],test[5],test[0]))
                        conn.commit()
                return redirect(url_for('Showdata'))

@app.route("/delete/<string:pcode>", methods=['GET'])
def delete(pcode):
        with conn.cursor() as cursor:
                cursor.execute("DELETE FROM qa WHERE Pattern_code=:pcode",pcode=pcode)
                conn.commit()
        return redirect(url_for('Showdata'))

if __name__ == "__main__":
    app.run(debug=True)

from flask import Flask,g,redirect,render_template,request,session,url_for
import pymysql

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
        session.pop('user_id',None)
        return redirect(url_for('login'))
##end login control##

#login database##
conn = pymysql.connect('localhost','root','Win102541','qa')

#index##
@app.route("/")
def Showdata():
        cur=conn.cursor()
        cur.execute("select * from data_pattern order by Pattern_code")
        rows = cur.fetchall()
        conn.commit()
        return render_template('index.html',datas=rows)

@app.route("/add")
def showForm():
        cur=conn.cursor()
        cur.execute("select * from data_pattern order by Pattern_code")
        rows = cur.fetchall()
        lengh = len(rows)
        if lengh < 10:
            p_id = 'A00'+str(lengh+1)
        elif lengh >= 10 and lengh < 100 :
            p_id = 'A0'+str(lengh+1)
        elif lengh < 1000 :
            p_id = 'A'+str(lengh+1)
        conn.commit()
        return render_template('adddata.html',patternid=p_id)

@app.route("/insert",methods=['POST'])
def insert():
        test=['0','0','0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":

                cur=conn.cursor()
                cur.execute("select * from data_pattern order by Pattern_code")
                rows = cur.fetchall()
                lengh = len(rows)
                if lengh < 10:
                    p_id = 'A00'+str(lengh+1)
                elif lengh >= 10 and lengh < 100 :
                    p_id = 'A0'+str(lengh+1)
                elif lengh < 1000 :
                    p_id = 'A'+str(lengh+1)
                conn.commit()

                test[0]=p_id
                test[1]=request.form['pn']
                test[2]=request.form['sqlcode']
                test[3]=request.form['system']
                test[4]=request.form['confident']
                test[5]=request.form['relate']
                test[6]=request.form['sequence']
                test[7]=request.form['frequency']
                test[8]=request.form['auto']
                test[9]=request.form['manual']
                test[10]=request.form['tag']
                test[11]="Enable"

                with conn.cursor() as cursor:
                        cursor.execute("insert into data_pattern(Pattern_code,Pattern_name,Sql_code,System_Detail,Confidentscore,relate,sequence,frequency,automate_path,manual_path,tag,status) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8],test[9],test[10],test[11]))
                        conn.commit()
                return redirect(url_for('Showdata'))

@app.route("/update",methods=['POST'])
def update():
        test=['0','0','0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":

                test[0]=request.form['pc']
                test[1]=request.form['pn']
                test[2]=request.form['sqlcode']
                test[3]=request.form['system']
                test[4]=request.form['confident']
                test[5]=request.form['relate']
                test[6]=request.form['sequence']
                test[8]=request.form['auto']
                test[9]=request.form['manual']
                test[10]=request.form['tag']
                test[11]=request.form['status']

                with conn.cursor() as cursor:
                        cursor.execute("update data_pattern set Pattern_name=%s ,Sql_code=%s ,System_Detail=%s ,Confidentscore=%s ,relate=%s,sequence=%s,automate_path=%s,manual_path=%s,tag=%s,status=%s where Pattern_code=%s",(test[1],test[2],test[3],test[4],test[5],test[6],test[8],test[9],test[10],test[11],test[0]))
                        conn.commit()
                return redirect(url_for('Showdata'))

if __name__ == "__main__":
    app.run(debug=True)

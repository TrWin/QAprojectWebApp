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
            return redirect(url_for('profile'))             #login success

        return redirect(url_for('login'))                   #invalid pw

    return render_template('login.html')

@app.route('/profile')
def profile():
    if not g.user:
        return redirect(url_for('login'))
    else :
        cur=conn.cursor()
        cur.execute("select * from data_pattern order by Pattern_code")
        rows = cur.fetchall()
        conn.commit()
        return render_template('index.html',datas=rows)

@app.route('/dropsession')
def dropsession():
        session.pop('user_id',None)
        return redirect(url_for('Showdata'))
##end login control##

#login database##
conn = pymysql.connect('localhost','root','test','qa')

#index##
@app.route("/")
def Showdata():
        cur=conn.cursor()
        cur.execute("""select * from data_pattern where status = "Enable" order by Pattern_code""")
        rows = cur.fetchall()
        conn.commit()
        return render_template('profile.html',datas=rows)


@app.route("/add")
def showForm():
        cur=conn.cursor()
        cur.execute("select * from data_pattern order by Pattern_code")
        rows = cur.fetchall()
        lengh = len(rows)
        if lengh < 9:
            p_id = 'A00'+str(lengh+1)
        elif lengh >= 9 and lengh < 99 :
            p_id = 'A0'+str(lengh+1)
        elif lengh >= 99:
            p_id = 'A'+str(lengh+1)
        conn.commit()
        return render_template('adddata.html',patternid=p_id)

@app.route("/insert",methods=['POST'])
def insert():
        test=['0','0','0','0','0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":

                cur=conn.cursor()
                cur.execute("select * from data_pattern order by Pattern_code")
                rows = cur.fetchall()
                lengh = len(rows)
                if lengh < 9:
                    p_id = 'A00'+str(lengh+1)
                elif lengh >= 9 and lengh < 99 :
                    p_id = 'A0'+str(lengh+1)
                elif lengh >= 99 :
                    p_id = 'A'+str(lengh+1)
                conn.commit()

                test[0]=p_id
                test[1]=request.form['pn']
                test[2]=request.form['type']
                test[3]=request.form['sqlcode']
                test[4]=request.form['system']
                test[5]=request.form['confident']
                test[6]=request.form['relate']
                test[7]=request.form['sequence']
                test[8]=request.form['frequency']
                test[9]=request.form['auto']
                test[10]=request.form['manual']
                test[11]=request.form['tag']
                test[12]=request.form['remark']
                test[13]="Enable"

                with conn.cursor() as cursor:
                        cursor.execute("insert into data_pattern(Pattern_code,Pattern_name,type,Sql_code,System_Detail,Confidentscore,relate,sequence,frequency,automate_path,manual_path,tag,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8],test[9],test[10],test[11],test[12],test[13]))
                        conn.commit()
                return redirect(url_for('Showdata'))

@app.route("/update",methods=['POST'])
def update():
        test=['0','0','0','0','0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":

                test[0]=request.form['pc']
                test[1]=request.form['pn']
                test[2]=request.form['type']
                test[3]=request.form['sqlcode']
                test[4]=request.form['system']
                test[5]=request.form['confident']
                test[6]=request.form['relate']
                test[7]=request.form['sequence']
                test[9]=request.form['auto']
                test[10]=request.form['manual']
                test[11]=request.form['tag']
                test[12]=request.form['remark']
                test[13]=request.form['status']

                with conn.cursor() as cursor:
                        cursor.execute("update data_pattern set Pattern_name=%s ,type=%s ,Sql_code=%s ,System_Detail=%s ,Confidentscore=%s ,relate=%s,sequence=%s,automate_path=%s,manual_path=%s,tag=%s,remark=%s,status=%s where Pattern_code=%s",(test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[9],test[10],test[11],test[12],test[13],test[0]))
                        conn.commit()
                return redirect(url_for('Showdata'))

@app.route("/count/<string:pcode>", methods=['GET'])
def count(pcode):
        cur = conn.cursor()
        cur.execute("select * from data_pattern where pattern_code=%s",pcode)
        row = cur.fetchone()
        with conn.cursor() as cursor:
            cursor.execute("update data_pattern set frequency=%s where pattern_code=%s",(str(int(row[8])+1), pcode))
            conn.commit()
        return redirect(url_for('Showdata'))

if __name__ == "__main__":
    app.run(debug=True)

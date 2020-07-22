from flask import Flask,g,redirect,render_template,request,session,url_for,flash
from werkzeug.utils import secure_filename
import os
import db
import pandas as pd
import csv


app = Flask(__name__)
app.secret_key = 'somesecretkeythatonlyishouldknow'

#login database##
#conn = db.get_db()
#conn = pymysql.connect('localhost','root','test','qa')

##login control##
class User:
    def __init__(self, id, username, password, typeRole):
        self.id = id
        self.username = username
        self.password = password
        self.typeRole = typeRole

    def __repr__(self):
        return f'<User: {self.username}>'


@app.before_request
def before_request():
        g.user = None

        conn = db.get_db()
        cur = conn.cursor()
        cur.execute("select id from user_password")
        idDB = cur.fetchall()
        cur.execute("select username from user_password")
        userDB = cur.fetchall()
        cur.execute("select password from user_password")
        pwDB = cur.fetchall()
        cur.execute("select type from user_password")
        typeDB = cur.fetchall()
        conn.commit()

        users = []
        users.append(User(id=0, username='admin', password='12345678', typeRole='admin'))
        for i in range(len(idDB)):
                users.append(User(id=idDB[i][0], username=userDB[i][0], password=pwDB[i][0], typeRole=typeDB[i][0]))

        if 'user_id' in session:
                user = [x for x in users if x.id == session['user_id']][0]
                g.user = user
        

#login control
@app.route('/', methods=['GET', 'POST'])
def login():
    conn = db.get_db()
    cur = conn.cursor()
    cur.execute("select id from user_password")
    idDB = cur.fetchall()
    cur.execute("select username from user_password")
    userDB = cur.fetchall()
    cur.execute("select password from user_password")
    pwDB = cur.fetchall()
    cur.execute("select type from user_password")
    typeDB = cur.fetchall()
    conn.commit()

    users = []
    users.append(User(id=0, username='admin', password='12345678', typeRole='admin'))
    for i in range(len(idDB)):
        users.append(User(id=idDB[i][0], username=userDB[i][0], password=pwDB[i][0], typeRole=typeDB[i][0]))

    if g.user:
        return redirect(url_for('profile'))
    if request.method == 'POST':
        session.pop('user_id', None)

        username = request.form['username']
        password = request.form['password']
        
        user = [x for x in users if x.username == username][0]
        if user and user.password == password:
            session['user_id'] = user.id
            if user.typeRole == 'admin':
                return redirect(url_for('profile'))            
            elif user.typeRole == 'qa':
                return redirect(url_for('Showdata'))
            elif user.typeRole == '3rdsit':
                return redirect(url_for('Show3SIT'))
        return redirect(url_for('login'))                  
    return render_template('login.html')

@app.route('/dropsession')
def dropsession():
        session.pop('user_id',None)
        return redirect(url_for('login'))
##end login control##

#Show main table
@app.route('/profile')
def profile():
    if not g.user:
        return redirect(url_for('login'))
    elif str(g.user) == '<User: admin>':
        conn = db.get_db()
        cur=conn.cursor()
        check = request.args.get('check')              
        cur.execute("select * from data_pattern order by Pattern_code")
        rows = cur.fetchall()
        cur.execute("select * from for_3rd_party order by pattern_code")
        third = cur.fetchall()
        cur.execute("select * from for_sit order by pattern_code")
        sit = cur.fetchall()
        cur.execute("""select * from automate_test_data order by thai_id""")
        auto = cur.fetchall()
        cur.execute("select * from document order by pattern_code")
        doc = cur.fetchall()
        cur.execute("select * from env order by oursystem")
        env = cur.fetchall()
        cur.execute("select distinct ourset from env")
        ourset = cur.fetchall()  

        cur.execute("select * from update_log where updated_table='qa'")
        qaUpdate = cur.fetchone()
        cur.execute("select * from update_log where updated_table='third'")
        thirdUpdate = cur.fetchone()
        cur.execute("select * from update_log where updated_table='sit'")
        sitUpdate = cur.fetchone()
        cur.execute("select * from update_log where updated_table='auto'")
        autoUpdate = cur.fetchone()
        cur.execute("select * from update_log where updated_table='doc'")
        docUpdate = cur.fetchone()
        cur.execute("select * from update_log where updated_table='env'")
        envUpdate = cur.fetchone()

        conn.commit()
        return render_template('admin.html',datas=rows,qaUpdate=qaUpdate,
                                                rd=third,thirdUpdate=thirdUpdate,
                                                sit=sit,sitUpdate=sitUpdate,
                                                auto=auto,autoUpdate=autoUpdate,
                                                doc=doc,docUpdate=docUpdate,
                                                env=env,envUpdate=envUpdate,
                                                ourset=ourset,
                                                check=check)
    else:
        return redirect(url_for('dropsession'))

@app.route("/qa")
def Showdata():
        if not g.user:
                return redirect(url_for('login'))
        elif str(g.user) == '<User: qauser>':  
                conn = db.get_db()
                check = request.args.get('check')                            
                cur=conn.cursor()
                cur.execute("""select * from data_pattern where status = "Enable" order by Pattern_code""")
                rows = cur.fetchall()
                cur.execute("""select * from for_3rd_party where status = "Enable" order by pattern_code""")
                third = cur.fetchall()
                cur.execute("""select * from for_sit where status = "Enable" order by Pattern_code""")
                sit = cur.fetchall()
                cur.execute("""select * from automate_test_data order by thai_id""")
                auto = cur.fetchall()
                cur.execute("""select * from document where status = "Enable" order by Pattern_code""")
                doc = cur.fetchall()
                cur.execute("""select * from env where status = "Enable" order by oursystem""")
                env = cur.fetchall() 
                
                cur.execute("select * from update_log where updated_table='qa'")
                qaUpdate = cur.fetchone()
                cur.execute("select * from update_log where updated_table='third'")
                thirdUpdate = cur.fetchone()
                cur.execute("select * from update_log where updated_table='sit'")
                sitUpdate = cur.fetchone()
                cur.execute("select * from update_log where updated_table='auto'")
                autoUpdate = cur.fetchone()
                cur.execute("select * from update_log where updated_table='doc'")
                docUpdate = cur.fetchone()
                cur.execute("select * from update_log where updated_table='env'")
                envUpdate = cur.fetchone()
        
                conn.commit()
                return render_template('user.html',datas=rows,qaUpdate=qaUpdate,
                                                        rd=third,thirdUpdate=thirdUpdate,
                                                        sit=sit,sitUpdate=sitUpdate,
                                                        auto=auto,autoUpdate=autoUpdate,
                                                        doc=doc,docUpdate=docUpdate,
                                                        env=env,envUpdate=envUpdate,
                                                        check=check)
        else:
                return redirect(url_for('dropsession'))

@app.route("/3sit")
def Show3SIT():
        if not g.user:
                return redirect(url_for('login'))
        elif str(g.user) == '<User: 3situser>':  
                check = request.args.get('check')
                conn = db.get_db()              
                cur=conn.cursor()

                cur.execute("""select * from for_3rd_party where status = "Enable" order by pattern_code""")
                third = cur.fetchall()
                cur.execute("""select * from for_sit where status = "Enable" order by Pattern_code""")
                sit = cur.fetchall()

                cur.execute("select * from update_log where updated_table='third'")
                thirdUpdate = cur.fetchone()
                cur.execute("select * from update_log where updated_table='sit'")
                sitUpdate = cur.fetchone()

                conn.commit()
                return render_template('user_sit.html',rd=third,thirdUpdate=thirdUpdate,sit=sit,sitUpdate=sitUpdate,check=check)
        else:
                return redirect(url_for('dropsession'))
#end Show main table


#For_QA#
@app.route("/add")
def showForm():
        conn = db.get_db()
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
        return render_template('adddata/adddataQA.html',patternid=p_id)

@app.route("/insert",methods=['POST'])
def insert():
        test=['0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0']
        check = 'qaAdmin'
        if request.method=="POST":
                conn = db.get_db()
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
                test[14] = "Automate"
                test[15] = "Manual"

                with conn.cursor() as cursor:
                        cursor.execute("insert into data_pattern(Pattern_code,Pattern_name,type,Sql_code,System_Detail,Confidentscore,relate,sequence,frequency,automate_path,manual_path,tag,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8],test[9],test[10],test[11],test[12],test[13]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'qa') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user))) 

                        if test[9] != '' :
                                cursor.execute("insert into document(Pattern_code,type,path,status) values(%s,%s,%s,%s)",(test[0],test[14],test[9],test[13]))
                        if test[10] != '':
                                cursor.execute("insert into document(Pattern_code,type,path,status) values(%s,%s,%s,%s)",(test[0],test[15],test[10],test[13]))

                        conn.commit()
                return redirect(url_for('profile',check=check))

@app.route("/update",methods=['POST'])
def update():
        test=['0','0','0','0','0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":
                check='qaAdmin'
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

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("update data_pattern set Pattern_name=%s ,type=%s ,Sql_code=%s ,System_Detail=%s ,Confidentscore=%s ,relate=%s,sequence=%s,automate_path=%s,manual_path=%s,tag=%s,remark=%s,status=%s where Pattern_code=%s",(test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[9],test[10],test[11],test[12],test[13],test[0]))
                        
                        cursor.execute("update document set path=%s where Pattern_code=%s and type='Automate'",(test[9],test[0]))
                        cursor.execute("update document set path=%s where Pattern_code=%s and type='Manual'",(test[10],test[0]))

                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'qa') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))

                        conn.commit()
                return redirect(url_for('profile',check=check))


@app.route("/count/<string:pcode>", methods=['GET'])
def count(pcode):
        conn = db.get_db()
        cur = conn.cursor()
        cur.execute("select * from data_pattern where pattern_code=%s",pcode)
        row = cur.fetchone()
        with conn.cursor() as cursor:
            cursor.execute("update data_pattern set frequency=%s where pattern_code=%s",(str(int(row[8])+1), pcode))
            conn.commit()

        return redirect(url_for('Showdata'))    
#For_QA#


#For 3rd Party#
@app.route("/addparty")
def showFormparty():
        conn = db.get_db()
        cur=conn.cursor()
        cur.execute("""select distinct ourset from env """)
        ourset = cur.fetchall()        
        conn.commit()
        return render_template('adddata/adddata3.html',ourset=ourset)

@app.route("/insertparty",methods=['POST'])
def insertparty():
        test=['0','0','0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":
                check = 'thirdAdmin'
                test[0]=request.form['pc']
                test[1]=request.form['pn']
                test[2]=request.form['thai']
                test[3]=request.form['ban']
                test[4]=request.form['product']
                test[5]=request.form['company']
                test[6]=request.form['use']
                test[7]=request.form['env']
                test[10]=request.form['remark']
                test[11]="Enable"

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("insert into for_3rd_party(Pattern_code,Pattern_name,thai_id,ban,product_id,company,enquiry,test_env,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[10],test[11]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'third') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                        conn.commit() 
                return redirect(url_for('profile',check=check))

@app.route("/updateparty",methods=['POST'])
def updateparty():
        test=['0','0','0','0','0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":

                conn = db.get_db()
                if str(g.user) == '<User: admin>': 
                        check = 'thirdAdmin'
                        test[0]=request.form['pc']
                        test[1]=request.form['pn']
                        test[2]=request.form['thai']
                        test[3]=request.form['ban']
                        test[4]=request.form['product']
                        test[5]=request.form['company']
                        test[6]=request.form['use']
                        test[7]=request.form['env']
                        test[8]=request.form['current']
                        test[9]=request.form['periods']
                        test[10]=request.form['remark']
                        test[11]=request.form['status']
                        test[12]=request.form['id']

                        with conn.cursor() as cursor:
                                cursor.execute("update for_3rd_party set Pattern_code=%s, Pattern_name=%s ,thai_id=%s ,ban=%s ,product_id=%s ,company=%s ,enquiry=%s ,test_env=%s ,current=%s ,period_start=%s,remark=%s ,status=%s  where id=%s",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8],test[9],test[10],test[11],test[12]))
                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'third') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))
                                conn.commit()
                        return redirect(url_for('profile',check=check))

                elif str(g.user) == '<User: 3situser>': 
                        check = 'third3SIT'
                        test[8]=request.form['current']
                        test[9]=request.form['periods']
                        test[12]=request.form['id']
                        test[13]=request.form['periode']

                        with conn.cursor() as cursor:
                                cursor.execute("update for_3rd_party set current=%s ,period_start=%s where id=%s",(test[8],test[9],test[12]))
                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'third') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))
                                conn.commit()
                        return redirect(url_for('Show3SIT',check=check))

@app.route("/enquiry",methods=['POST'])
def enquiry():
        test=['0','0']
        if request.method=="POST":
                test[0]=request.form['use']
                test[1]=request.form['id']
                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("update for_3rd_party set enquiry=%s  where id=%s",(test[0],test[1]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'third') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        

                        conn.commit()
                return redirect(url_for('Showdata'))

@app.route("/3sitparty",methods=['POST'])
def party3sit():
        test=['0','0','0','0','0','0','0','0']
        if request.method=="POST":
                test[0]=request.form['oldUser']
                test[1]=request.form['id']
                test[2]=request.form['current']
                test[3]=request.form['periods']
                test[4]=request.form['periode']
                mix = str(test[3])+"  to  "+str(test[4])
                user = str(test[0])+"           . "+str(test[2])
                test[5]=request.form['oldPeriods']+"   "+mix
                test[6] = "3rd"

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("update for_3rd_party set current=%s, period_start=%s  where id=%s",(user,test[5],test[1]))
                        cursor.execute("insert into c_user(current,period_start,period_end,type) values(%s,%s,%s,%s)",(test[2],test[3],test[4],test[6]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'third') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        

                        conn.commit()
                return redirect(url_for('Show3SIT'))
#For 3rd Party#


#For sit##
@app.route("/addsit")
def showFormsit():
        conn = db.get_db()
        cur=conn.cursor()
        cur.execute("""select distinct ourset from env """)
        env = cur.fetchall() 
        conn.commit()
        return render_template('adddata/adddataSIT.html',env=env)

@app.route("/insertsit",methods=['POST'])
def insertsit():
        test=['0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":
                check = 'sitAdmin'
                test[0]=request.form['pc']
                test[1]=request.form['thai']
                test[2]=request.form['ban']
                test[3]=request.form['product']
                test[4]=request.form['company']
                test[5]=request.form['env']
                test[8]=request.form['remark']
                test[9]="Enable"

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("insert into for_sit(Pattern_code,thai_id,ban,product_id,company,test_env,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[8],test[9]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'sit') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))
                        conn.commit()
                return redirect(url_for('profile',check=check))


@app.route("/updatesit",methods=['POST'])
def updatesit():
        test=['0','0','0','0','0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":
                conn = db.get_db()
                if str(g.user) == '<User: admin>': 
                        check = 'sitAdmin'
                        test[0]=request.form['pc']
                        test[1]=request.form['thai']
                        test[2]=request.form['ban']
                        test[3]=request.form['product']
                        test[4]=request.form['company']
                        test[5]=request.form['env']
                        test[6]=request.form['current']
                        test[7]=request.form['periods']
                        test[8]=request.form['remark']
                        test[9]=request.form['status']
                        test[10]=request.form['id']

                        with conn.cursor() as cursor:
                                cursor.execute("update for_sit set Pattern_code=%s, thai_id=%s ,ban=%s ,product_id=%s ,company=%s ,test_env=%s,current=%s,period_start=%s,remark=%s,status=%s where id=%s",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8],test[9],test[10]))
                                cursor.execute("update for_sit set Pattern_code=%s, thai_id=%s ,ban=%s ,product_id=%s ,company=%s ,test_env=%s,current=%s,period_start=%s,remark=%s,status=%s where id=%s",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8],test[9],test[10]))
                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'sit') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))
                                conn.commit()
                        return redirect(url_for('profile',check=check))
                elif str(g.user) == '<User: 3situser>': 
                        check = 'sit3SIT'
                        test[8]=request.form['current']
                        test[9]=request.form['periods']
                        test[12]=request.form['id']
                        test[13]=request.form['periode']

                        with conn.cursor() as cursor:
                                cursor.execute("update for_sit set current=%s ,period_start=%s where id=%s",(test[8],test[9],test[12]))
                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'sit') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))
                                conn.commit()
                        return redirect(url_for('Show3SIT',check=check))

@app.route("/3sitx",methods=['POST'])
def sit3sit():
        test=['0','0','0','0','0','0','0','0']
        if request.method=="POST":
                check = 'sit3SIT'
                test[0]=request.form['oldUser']
                test[1]=request.form['id']
                test[2]=request.form['current']
                test[3]=request.form['periods']
                test[4]=request.form['periode']
                mix = str(test[3])+"  to  "+str(test[4])
                user = str(test[0])+"                   . "+str(test[2])
                test[5]=request.form['oldPeriods']+"   "+mix
                test[6] = "sit"

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("update for_sit set current=%s, period_start=%s  where id=%s",(user,test[5],test[1]))
                        cursor.execute("insert into c_user(current,period_start,period_end,type) values(%s,%s,%s,%s)",(test[2],test[3],test[4],test[6]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'third') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        

                        conn.commit()
                return redirect(url_for('Show3SIT',check=check))
#end sit##


#For Automate##
@app.route("/addauto")
def showFormAuto():
        conn = db.get_db()
        conn.commit()
        return render_template('adddata/adddataAutomate.html')

@app.route("/insertauto",methods=['POST'])
def insertAuto():
        test=['0','0','0','0','0','0','0','0']

        test[0]=request.form['thai']
        test[1]=request.form['ban']
        test[2]=request.form['product']
        test[3]=request.form['company']
        test[4]=request.form['env']
        test[5]=request.form['owner']
        test[6]=request.form['remark']
        test[7]="Enable"

        conn = db.get_db()
        with conn.cursor() as cursor:
            cursor.execute("insert into automate_test_data(thai_id,ban,product_id,company,test_env,owner,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7]))
            cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'auto') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))
            conn.commit()
        
        if str(g.user) == '<User: admin>': 
                check = 'autoAdmin'
                return redirect(url_for('profile',check=check))
        elif str(g.user) == '<User: qauser>': 
                check = 'autoQA'
                return redirect(url_for('Showdata',check=check))

@app.route("/updateauto",methods=['POST'])
def updateAuto():
        test=['0','0','0','0','0','0','0','0','0']
        if request.method=="POST": 
                test[0]=request.form['thai']
                test[1]=request.form['ban']
                test[2]=request.form['product']
                test[3]=request.form['company']
                test[4]=request.form['env']
                test[5]=request.form['owner']
                test[6]=request.form['remark']
                test[7]=request.form['status']
                test[8]=request.form['id']

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("update automate_test_data set thai_id=%s, ban=%s ,product_id=%s ,company=%s ,test_env=%s ,owner=%s ,remark=%s ,status=%s where id=%s",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'auto') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                        conn.commit()
                
                if str(g.user) == '<User: admin>': 
                        check = 'autoAdmin'
                        return redirect(url_for('profile',check=check))
                elif str(g.user) == '<User: qauser>': 
                        check = 'autoQA'
                        return redirect(url_for('Showdata',check=check))
#end Automate##


#For document##
@app.route("/adddoc")
def showFormdoc():
        conn = db.get_db()
        conn.commit()
        return render_template('adddata/adddataDoc.html')

@app.route("/insertdoc",methods=['POST'])
def insertdoc():
        test=['0','0','0','0','0','0','0']
        if request.method=="POST":
                check='docAdmin'
                test[0]=request.form['pc']
                test[1]=request.form['type']
                test[2]=request.form['path']
                test[3]=request.form['fn']
                test[4]=request.form['topic']
                test[5]=request.form['remark']
                test[6]="Enable"

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("insert into document(Pattern_code,type,path,file_name,topic,remark,status) values(%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'doc') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                        conn.commit()
                return redirect(url_for('profile',check=check))

@app.route("/updatedoc",methods=['POST'])
def updatedoc():
        test=['0','0','0','0','0','0','0','0']
        if request.method=="POST":
                check='docAdmin'
                test[0]=request.form['pc']
                test[1]=request.form['type']
                test[2]=request.form['path']
                test[3]=request.form['fn']
                test[4]=request.form['topic']
                test[5]=request.form['remark']
                test[6]=request.form['status']
                test[7]=request.form['id']
                auto='Automate'
                manual='Manual'

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("update document set Pattern_code=%s, type=%s ,path=%s ,file_name=%s ,topic=%s ,remark=%s,status=%s where id=%s ",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7]))
                        if test[1] == auto:
                                cursor.execute("update data_pattern set automate_path=%s where pattern_code=%s ",(test[2],test[0]))
                        elif test[1] == manual:
                                cursor.execute("update data_pattern set manual_path=%s where pattern_code=%s ",(test[2],test[0]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'doc') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                        conn.commit()
                return redirect(url_for('profile',check=check))
#end document##


#For env##
@app.route("/addenv")
def showFormEnv():
        conn = db.get_db()
        conn.commit()
        return render_template('adddata/adddataEnv.html')

@app.route("/insertenv",methods=['POST'])
def insertEnv():
        check='envAdmin'
        test=['0','0','0','0','0','0','0','0','0']

        test[0]=request.form['system']
        test[1]=request.form['db']
        test[2]=request.form['set']
        test[3]=request.form['path']
        test[4]=request.form['ip']
        test[5]=request.form['passApp']
        test[6]=request.form['passDb']
        test[7]=request.form['remark']
        test[8]="Enable"

        conn = db.get_db()
        with conn.cursor() as cursor:
            cursor.execute("insert into env(oursystem,db,ourset,path,ip,user_pass_app,user_pass_db,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8]))
            cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'env') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
            conn.commit()
        return redirect(url_for('profile',check=check))

@app.route("/updateenv",methods=['POST'])
def updateEnv():
        test=['0','0','0','0','0','0','0','0','0','0']
        if request.method=="POST":
                check = 'envAdmin'
                test[0]=request.form['system']
                test[1]=request.form['db']
                test[2]=request.form['set']
                test[3]=request.form['path']
                test[4]=request.form['ip']
                test[5]=request.form['passApp']
                test[6]=request.form['passDb']
                test[7]=request.form['remark']
                test[8]=request.form['status']
                test[9]=request.form['id']

                conn = db.get_db()
                with conn.cursor() as cursor:
                        cursor.execute("update env set oursystem=%s, db=%s ,ourset=%s ,path=%s ,ip=%s ,user_pass_app=%s ,user_pass_db=%s ,remark=%s ,status=%s where id=%s",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8],test[9]))
                        cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'env') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                        conn.commit()
                return redirect(url_for('profile',check=check))
#end env##


#import file##
UPLOAD_FOLDER = 'testFlask/uploads/'
ALLOWED_EXTENSIONS = {'csv'}

app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/uploads', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        conn = db.get_db()
        check='qaAdmin'
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

                test =['0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0']

                with open('testFlask/uploads/'+filename) as csvfile:
                        reader = csv.reader(csvfile)
                        line_count = 0
                        for row in reader:
                                if line_count == 0:
                                        line_count = line_count + 1
                                else:
                                        conn = db.get_db()
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

                                        test[0]=p_id
                                        test[1]=row[0]
                                        test[2]=row[1]
                                        test[3]=row[2]
                                        test[4]=row[3]
                                        test[5]=row[4]
                                        test[6]=row[5]
                                        test[7]=row[6]
                                        test[8]=row[7]
                                        test[9]=row[8]
                                        test[10]=row[9]
                                        test[11]=row[10]
                                        test[12]=row[11]
                                        test[13]="Enable"
                                        test[14] ="Automate"
                                        test[15] ="Manual"
                                        line_count = line_count + 1


                                                

                                        with conn.cursor() as cursor:
                                                cursor.execute("insert into data_pattern(Pattern_code,Pattern_name,type,Sql_code,System_Detail,Confidentscore,relate,sequence,frequency,automate_path,manual_path,tag,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8],test[9],test[10],test[11],test[12],test[13]))
                                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'qa') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                                                
                                                if test[9] != '' :
                                                        cursor.execute("insert into document(Pattern_code,type,path,status) values(%s,%s,%s,%s)",(test[0],test[14],test[9],test[13]))
                                                if test[10] != '':
                                                        cursor.execute("insert into document(Pattern_code,type,path,status) values(%s,%s,%s,%s)",(test[0],test[15],test[10],test[13]))

                                                conn.commit()



    return redirect(url_for('profile',check=check))

@app.route('/uploads3rd', methods=['GET', 'POST'])
def upload_file3rd():
    if request.method == 'POST':
        conn = db.get_db()
        check = 'thirdAdmin'
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            
                test=['0','0','0','0','0','0','0','0','0','0','0','0']

                with open('testFlask/uploads/'+filename) as csvfile:
                        reader = csv.reader(csvfile)
                        line_count = 0
                        for row in reader:
                                if line_count == 0:
                                        line_count = line_count + 1
                                else:
                                        conn = db.get_db()

                                        test[0]=row[0]
                                        test[1]=row[1]
                                        test[2]=row[2]
                                        test[3]=row[3]
                                        test[4]=row[4]
                                        test[5]=row[5]
                                        test[6]=row[6]
                                        test[7]=row[7]
                                        test[10]=row[8]
                                        test[11]="Enable"
                                        line_count = line_count + 1


                                                

                                        with conn.cursor() as cursor:
                                                cursor.execute("insert into for_3rd_party(Pattern_code,Pattern_name,thai_id,ban,product_id,company,enquiry,test_env,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[10],test[11]))
                                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'third') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                                                conn.commit()


    return redirect(url_for('profile',check=check))

@app.route('/uploadsSit', methods=['GET', 'POST'])
def upload_fileSit():
    if request.method == 'POST':
        conn = db.get_db()
        check = 'sitAdmin'
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                
                test=['0','0','0','0','0','0','0','0','0','0']

                with open('testFlask/uploads/'+filename) as csvfile:
                        reader = csv.reader(csvfile)
                        line_count = 0
                        for row in reader:
                                if line_count == 0:
                                        line_count = line_count + 1
                                else:
                                        conn = db.get_db()

                                        test[0]=row[0]
                                        test[1]=row[1]
                                        test[2]=row[2]
                                        test[3]=row[3]
                                        test[4]=row[4]
                                        test[5]=row[5]
                                        test[8]=row[6]
                                        test[9]="Enable"
                                        line_count = line_count + 1


                                                

                                        with conn.cursor() as cursor:
                                                cursor.execute("insert into for_sit(Pattern_code,thai_id,ban,product_id,company,test_env,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[8],test[9]))
                                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'sit') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))
                                                conn.commit()



    return redirect(url_for('profile',check=check))

@app.route('/uploadsDoc', methods=['GET', 'POST'])
def upload_fileDoc():
    if request.method == 'POST':
        conn = db.get_db()
        check = 'docAdmin'
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            
                test=['0','0','0','0','0','0','0']

                with open('testFlask/uploads/'+filename) as csvfile:
                        reader = csv.reader(csvfile)
                        line_count = 0
                        for row in reader:
                                if line_count == 0:
                                        line_count = line_count + 1
                                else:
                                        conn = db.get_db()

                                        test[0]=row[0]
                                        test[1]=row[1]
                                        test[2]=row[2]
                                        test[3]=row[3]
                                        test[4]=row[4]
                                        test[5]=row[5]
                                        test[6]="Enable"
                                        line_count = line_count + 1


                                                

                                        with conn.cursor() as cursor:
                                                cursor.execute("insert into document(Pattern_code,type,path,file_name,topic,remark,status) values(%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6]))
                                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'doc') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                                                conn.commit()



    return redirect(url_for('profile',check=check))

@app.route('/uploadsEnv', methods=['GET', 'POST'])
def upload_fileEnv():
    if request.method == 'POST':
        conn = db.get_db()
        check = 'envAdmin'
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            
                test=['0','0','0','0','0','0','0','0','0']

                with open('testFlask/uploads/'+filename) as csvfile:
                        reader = csv.reader(csvfile)
                        line_count = 0
                        for row in reader:
                                if line_count == 0:
                                        line_count = line_count + 1
                                else:
                                        conn = db.get_db()

                                        test[0]=row[0]
                                        test[1]=row[1]
                                        test[2]=row[2]
                                        test[3]=row[3]
                                        test[4]=row[4]
                                        test[5]=row[5]
                                        test[6]=row[6]
                                        test[7]=row[7]
                                        test[8]="Enable"
                                        line_count = line_count + 1


                                                

                                        with conn.cursor() as cursor:
                                                cursor.execute("insert into env(oursystem,db,ourset,path,ip,user_pass_app,user_pass_db,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7],test[8]))
                                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'env') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))                        
                                                conn.commit()



    return redirect(url_for('profile',check=check))

@app.route('/uploadsAuto', methods=['GET', 'POST'])
def upload_fileAuto():
    if request.method == 'POST':
        conn = db.get_db()
        check = 'autoAdmin'
        # check if the post request has the file part
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        # if user does not select file, browser also
        # submit an empty part without filename
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
                filename = secure_filename(file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                
                test=['0','0','0','0','0','0','0','0']

                with open('testFlask/uploads/'+filename) as csvfile:
                        reader = csv.reader(csvfile)
                        line_count = 0
                        for row in reader:
                                if line_count == 0:
                                        line_count = line_count + 1
                                else:
                                        conn = db.get_db()

                                        test[0]=row[0]
                                        test[1]=row[1]
                                        test[2]=row[2]
                                        test[3]=row[3]
                                        test[4]=row[4]
                                        test[5]=row[5]
                                        test[6]=row[6]
                                        test[7]="Enable"
                                        line_count = line_count + 1


                                                

                                        with conn.cursor() as cursor:
                                                cursor.execute("insert into automate_test_data(thai_id,ban,product_id,company,test_env,owner,remark,status) values(%s,%s,%s,%s,%s,%s,%s,%s)",(test[0],test[1],test[2],test[3],test[4],test[5],test[6],test[7]))
                                                cursor.execute("INSERT INTO update_log (updated_by, updated_date, updated_table) VALUES(%s, SYSDATE(), 'auto') ON DUPLICATE KEY UPDATE updated_by=%s, updated_date=SYSDATE()",(str(g.user),str(g.user)))
                                                conn.commit()

    return redirect(url_for('profile',check=check))

#end import##

@app.teardown_appcontext
def close_db(error):
    db.close_db()

if __name__ == "__main__":
    app.run(debug=True)
from flask import Flask,render_template,request,redirect,url_for
import cx_Oracle

app = Flask(__name__)
conn = cx_Oracle.connect('SYSTEM/Win102541@//localhost:1521/xe')

@app.route("/")
def Showdata():
        cur=conn.cursor()
        cur.execute("select * from qa order by Pattern_code")
        rows = cur.fetchall()
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
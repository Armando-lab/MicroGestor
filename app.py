from flask import Flask, jsonify
from flask import render_template, redirect, request, Response, session, url_for, flash
from flask_mysqldb import MySQL, MySQLdb
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__, template_folder='templates')

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'microgestor'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('landing.html')

@app.route('/landing')
def landing():
    return render_template('landing.html')

@app.route('/menu')
def menu():
    return render_template('menu.html')

@app.route('/inventario')
def inventario():
    return render_template('inventario.html')

@app.route('/ventas')
def ventas():
    return render_template('ventas.html')

@app.route('/agregar_producto')
def agregar_producto():
    return render_template('agregar_producto.html')

@app.route('/informacion_producto')
def informacion_producto():
    return render_template('informacion_producto.html')

@app.route('/mi_perfil', methods=['GET', 'POST'])
def mi_perfil():
    usuario_id = session.get('id')
    if not usuario_id:
        # Si no hay usuario_id en la sesión, redirigir al login o manejarlo como prefieras
        return redirect(url_for('menu'))

    if request.method == 'POST':
        # Recoger los datos enviados desde el formulario
        nombre = request.form['nombre']
        email = request.form['email']
        telefono = request.form['telefono']
        
        # Actualizar los datos en la base de datos
        try:
            cursor = mysql.connection.cursor()
            cursor.execute("""
                UPDATE usuarios
                SET nombre = %s, email = %s, numero_de_telefono = %s
                WHERE id = %s
            """, (nombre, email, telefono, usuario_id))
            mysql.connection.commit()   
            cursor.close()
            flash('Perfil actualizado exitosamente', 'success')
        except Exception as e:
            mysql.connection.rollback()
            flash('Error al actualizar el perfil: {}'.format(e), 'error')
        
        return redirect(url_for('mi_perfil'))
    else:
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT nombre, email, numero_de_telefono FROM usuarios WHERE id = %s", (usuario_id,))
        usuario = cursor.fetchone()
        cursor.close()
        return render_template('mi_perfil.html', usuario=usuario)



@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'GET':
        # Si es GET, simplemente mostramos el formulario de registro
        return render_template('registro.html')
    elif request.method == 'POST':
        # Recoger los datos del formulario
        nombre = request.form['nombreCompleto']
        email = request.form['emailRegistro']
        contrasena = request.form['passwordRegistro']
        numero_de_telefono = request.form['numeroTelefonico']

        # Intentamos insertar los datos en la base de datos
        try:
            cursor = mysql.connection.cursor()
            cursor.execute('INSERT INTO usuarios (nombre, email, contrasena, numero_de_telefono) VALUES (%s, %s, %s, %s)', (nombre, email, contrasena, numero_de_telefono))
            mysql.connection.commit()
            cursor.close()
            return jsonify({'success': True, 'message': 'Usuario registrado exitosamente.'}), 200
        except Exception as e:
            # En caso de error, hacemos rollback y devolvemos un error
            mysql.connection.rollback()
            return jsonify({'success': False, 'message': 'Error al registrar el usuario: {}'.format(str(e))}), 500


@app.route('/crear_empresa', methods=['GET', 'POST'])
def crear_empresa():
    if request.method == 'GET':
        # Si es GET, simplemente mostramos el formulario
        return render_template('crear_empresa.html')
    elif request.method == 'POST':
        # Obtenemos los datos del formulario
        nombre = request.form['nombre']
        direccion = request.form['direccion']
        giro_comercial = request.form['giro_comercial']
        # No necesitamos obtener la fecha de creación, se generará automáticamente

        # Intentamos insertar los datos en la base de datos
        try:
            cursor = mysql.connection.cursor()
            cursor.execute('INSERT INTO empresa (nombre, direccion, giro_comercial) VALUES (%s, %s, %s)', (nombre, direccion, giro_comercial))
            mysql.connection.commit()
            cursor.close()
            return jsonify({'success': True, 'message': 'Empresa creada exitosamente.'}), 200
        except Exception as e:
            # En caso de error, hacemos rollback y devolvemos un error
            mysql.connection.rollback()
            return jsonify({'success': False, 'message': 'Error al crear la empresa: {}'.format(str(e))}), 500    

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        cursor = mysql.connection.cursor()
        
        # Cambiamos 'nombre_usuario' por 'email' si ese es el método de inicio de sesión
        cursor.execute('SELECT * FROM usuarios WHERE email = %s', [username])
        usuario = cursor.fetchone()
        
        if usuario and check_password_hash(usuario['contrasena'], password):
            # El usuario existe y la contraseña es correcta
            session['loggedin'] = True
            session['id'] = usuario['id']
            session['nombre'] = usuario['nombre']  # Guardar el nombre en la sesión
            session['foto_del_perfil'] = usuario['foto_del_perfil']  # Guardar la foto en la sesión
            return redirect(url_for('mi_perfil'))
        else:
            flash('Nombre de usuario o contraseña incorrectos.')
            return redirect(url_for('login'))
    return render_template('login.html')



if __name__ == '__main__':
        app.secret_key = 'apk'
        app.run(debug=True, host='0.0.0.0', port=5000, threaded=True, use_reloader=False)
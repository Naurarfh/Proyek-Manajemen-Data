from flask import Flask, request, jsonify, render_template_string
import numpy as np

app = Flask(__name__)

# Halaman utama dengan form
HTML_FORM = '''
<!doctype html>
<html>
<head><title>Analisis Korelasi Data</title></head>
<body>
<h2>Analisis Korelasi Dua Variabel</h2>
<p>Masukkan data X dan Y (pisahkan dengan koma)</p>
<form method="POST" action="/korelasi">
    X: <input type="text" name="x" value="1,2,3,4,5"><br>
    Y: <input type="text" name="y" value="2,4,6,8,10"><br>
    <input type="submit" value="Hitung Korelasi">
</form>
</body>
</html>
'''

@app.route('/')
def index():
    return HTML_FORM

@app.route('/korelasi', methods=['POST'])
def korelasi():
    try:
        x_str = request.form.get('x', '')
        y_str = request.form.get('y', '')
        x = [float(i) for i in x_str.split(',')]
        y = [float(i) for i in y_str.split(',')]
        if len(x) != len(y) or len(x) < 2:
            return jsonify({'error': 'Jumlah data X dan Y harus sama dan minimal 2'})
        
        # Hitung koefisien korelasi Pearson
        corr_matrix = np.corrcoef(x, y)
        korelasi = corr_matrix[0, 1]
        
        # Hitung persamaan regresi linear sederhana (y = a + bx)
        b, a = np.polyfit(x, y, 1)
        
        hasil = {
            'korelasi_pearson': round(korelasi, 4),
            'persamaan_regresi': f'y = {round(a,2)} + {round(b,2)} * x',
            'jumlah_data': len(x)
        }
        return jsonify(hasil)
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

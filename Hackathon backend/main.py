import os
from google.cloud import storage
from flask import Flask, flash, request, redirect, url_for
from werkzeug.utils import secure_filename
bucket_name = 'ubhacking-331407.appspot.com'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif', 'usdz'])

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = '/tmp'

# def make_blob_public(bucket_name, blob_name):
#     """Makes a blob publicly accessible."""
#     # bucket_name = "your-bucket-name"
#     # blob_name = "your-object-name"

#     storage_client = storage.Client()
#     bucket = storage_client.bucket(bucket_name)
#     blob = bucket.blob(blob_name)

#     blob.make_public()

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/file-upload', methods=['POST'])
def upload_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            flash('No file part')
            return redirect(request.url)
        file = request.files['file']
        if file.filename == '':
            flash('No selected file')
            return redirect(request.url)
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
            file.save(filepath)
            name = '/{}/{}'.format(bucket_name, filename)
            storage_client = storage.Client()
            bucket = storage_client.get_bucket(bucket_name)
            blob = storage.Blob(name, bucket)
            blob.upload_from_filename(filepath)
            sri=bucket.blob(name)
            sri.make_public()
    return "Hello World!"

if __name__ == "__main__":
    app.run()





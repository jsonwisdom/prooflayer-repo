import hashlib
from google.cloud import storage


def sha256_file(path: str) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            h.update(chunk)
    return h.hexdigest()


def notarize(bucket_name: str, object_name: str, path: str):
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(object_name)
    blob.upload_from_filename(path)

    return {
        "gcs_uri": f"gs://{bucket_name}/{object_name}",
        "content_hash": sha256_file(path)
    }

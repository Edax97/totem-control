source .env
python "$SRC_DIR/copyparty-sfx.py" -v "$CONTENT_DIR:/content:r:rwd,adm" -a adm:labotec --allow-csrf --ftp=3921

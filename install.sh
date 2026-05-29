sudo apt install mpv socat ffmpeg yq
sudo apt install nginx
sudo systemctl enable --now nginx

#disable firefox crash recovery
# -- about:config
# browser.sessionstore.resume_from_crash False
# browser.sessionstore.max_resumed_crashes -1
# toolkit.startup.max_resumed_crashes -1

# install p2p
# 
# 
# 
# 

# install voice libraries
python -m venv $HOME/.pyenv
source $HOME/.pyenv/bin/activate
pip install -r voice/req.txt
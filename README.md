# wan2gp_stuff
wan2gp for rtx 40xx & 50xx - one click install

## RTX 50XX
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
$HOME/miniconda3/bin/conda init bash
source ~/.bashrc
git clone https://github.com/deepbeepmeep/Wan2GP.git
cd Wan2GP
# Fix matplotlib backend
sed -i "s/matplotlib.use('TkAgg')/matplotlib.use('Agg')/g" preprocessing/dwpose/util.py
conda create -n wan2gp python=3.10.9 -y
conda activate wan2gp
pip install torch==2.7.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
pip install -r requirements.txt
git clone https://github.com/thu-ml/SageAttention
cd SageAttention 
python setup.py install
cd ../
#ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6 ${CONDA_PREFIX}/lib/libstdc++.so.6
conda install -c conda-forge gcc_linux-64 gxx_linux-64 libstdcxx-ng -y
conda install -c conda-forge libstdcxx-ng -y
python wgp.py --share
```
## Launch
```bash
cd Wan2GP
conda activate wan2gp
python wgp.py --share
```

## RTX 40XX
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
$HOME/miniconda3/bin/conda init bash
source ~/.bashrc
git clone https://github.com/deepbeepmeep/Wan2GP.git
cd Wan2GP
# Fix matplotlib backend
sed -i "s/matplotlib.use('TkAgg')/matplotlib.use('Agg')/g" preprocessing/dwpose/util.py
conda create -n wan2gp python=3.10.9 -y
conda activate wan2gp
pip install torch==2.6.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
pip install -r requirements.txt
#ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6 ${CONDA_PREFIX}/lib/libstdc++.so.6
conda install -c conda-forge gcc_linux-64 gxx_linux-64 libstdcxx-ng -y
conda install -c conda-forge libstdcxx-ng -y
git clone https://github.com/thu-ml/SageAttention
cd SageAttention 
python setup.py install
cd ../
python wgp.py --share
```

## Lora Wan2.1_I2V_14B_FusionX
```bash
https://huggingface.co/vrgamedevgirl84/Wan14BT2VFusioniX/resolve/main/FusionX_LoRa/Wan2.1_I2V_14B_FusionX_LoRA.safetensors
```
## FFMPEG mix audio
```bash
ffmpeg -i video.mp4 -i 655565__sergequadrado__hush-little-baby.wav -filter_complex "[1:a]volume=1[a1];[0:a][a1]amix=inputs=2[a]" -map 0:v -map "[a]" -c:v copy -shortest output.mp4
```

## FFMPEG add audio
```bash
ffmpeg -i video.mp4 -i audio.mp3 -c:v copy -c:a aac -shortest output.mp4
```

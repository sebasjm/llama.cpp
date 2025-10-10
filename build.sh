# 2006  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
# 2007  sudo dpkg -i cuda-keyring_1.1-1_all.deb
# 2008  sudo apt-get update
# 2009  sudo apt-get -y install cuda-toolkit-13-0

export PATH=$PATH:/usr/local/cuda/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/lib
export CPLUS_INCLUDE_PATH=/usr/local/cuda/include

#To override the native GPU detection:

#1. Take note of the Compute Capability of your NVIDIA devices: "CUDA: Your GPU Compute > Capability".
#GeForce RTX 4090      8.9
#GeForce RTX 3080 Ti   8.6
#GeForce RTX 3070      8.6
#2. Manually list each varying Compute Capability in the CMAKE_CUDA_ARCHITECTURES list.
#cmake -B build -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES="86;89"

echo PREPARE

#cmake -B build -DGGML_CPU_ALL_VARIANTS=ON -DBUILD_SHARED_LIBS=ON -DGGML_BACKEND_DL=ON -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES="89" -DCMAKE_BUILD_TYPE=Debug
cmake -B build -DBUILD_SHARED_LIBS=OFF -DGGML_CUDA=ON -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CUDA_ARCHITECTURES=89

echo BUILDING

cmake --build build --config Debug --target llama-server


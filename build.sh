#! /bin/bash

# Build
if [ ! -d "build" ]; then
  mkdir build
fi

cd build

cmake -Dboost_filesystem_DIR=/usr/local/lib/cmake/boost_filesystem-1.70.0 \ 
      -Dboost_headers_DIR= /usr/local/lib/cmake/boost_headers-1.70.0 \ 
      -Dboost_python_DIR=/usr/local/lib/cmake/boost_python-1.70.0 \
      -Dboost_system_DIR=/usr/local/lib/cmake/boost_system-1.70.0 \
      -DCMAKE_INSTALL_PREFIX=/usr/local \ 
      -DBUILD_SHARED_LIBS=ON \ 
      -DBoost_USE_STATIC_LIBS=OFF ../
make
touch __init__.py

git clone https://github.com/Itseez/opencv_contrib
mv opencv_contrib/modules/saliency/samples/ObjectnessTrainedModel ./
rm -rf opencv_contrib

cd ..

wget http://farm1.static.flickr.com/121/278839518_140821637d.jpg -O sample.jpg
python scripts/test_bing.py

# !/bin/bash
# Source url: https://download.qt.io/official_releases/qt/
QT_SRC_URL=https://download.qt.io/official_releases/qt/6.4/6.4.0/single/qt-everywhere-src-6.4.0.tar.xz
QT_PACK_NAME="$(basename ${QT_SRC_URL})"
QT_PACK_DIR="$(basename ${QT_SRC_URL} .tar.xz)"
QT_INSTALL_PATH=${HOME}/Qt6
QT_BUILD_DIR=qt6-build
QT_SRC_TMP=qt6-src
QT_SRC_PATH="$(pwd)/${QT_SRC_TMP}/${QT_PACK_DIR}"
QT_CONFIGURE=${QT_SRC_PATH}/configure

# Install requirement packages
sudo apt install -y build-essential \
                    libx11-dev \
                    ninja-build \
                    openssl libssl-dev \
                    libmd4c-dev libmd4c-html0-dev \
                    pkg-config \
                    mesa-utils libglu1-mesa-dev freeglut3-dev mesa-common-dev \
                    libglew-dev libglfw3-dev libglm-dev \
                    libao-dev libmpg123-dev

echo ""

mkdir -p ${QT_SRC_TMP}
cd  ${QT_SRC_TMP}

# Download qt6 source code
echo "Download ${QT_SRC_URL}"
[ ! -f ${QT_PACK_NAME} ] && wget ${QT_SRC_URL}

# Extract downloaded archive
echo "Extract file: ${QT_PACK_NAME}"
[ ! -d ${QT_PACK_DIR} ] && mkdir -p ${QT_PACK_DIR} && tar xf ${QT_PACK_NAME}

mkdir -p ${QT_BUILD_DIR}
cd ${QT_BUILD_DIR}
 
# Configure qt6 module
echo "Start to configure qt6 repository"
${QT_CONFIGURE} -prefix $QT_INSTALL_PATH -DQT_NO_EXCEPTIONS=1 -debug-and-release -force-debug-info -opensource -confirm-license \
-c++std c++20 -static -static-runtime -openssl-linked \
-skip qt3d -skip qt5compat -skip qtactiveqt -skip qtcharts -skip qtcoap -skip qtconnectivity \
-skip qtdatavis3d -skip qtdoc -skip qtlottie -skip qtmqtt -skip qtnetworkauth -skip qtopcua \
-skip qtserialport -skip qtpositioning -skip qtquicktimeline -skip qtquick3d -skip qtremoteobjects \
-skip qtscxml -skip qtsensors -skip qtserialbus -skip qtvirtualkeyboard -skip qtwayland \
-skip qtwebchannel -skip qtwebengine -skip qtwebview -skip qtquick3dphysics -skip qtspeech -skip qtlocation \
-skip qthttpserver

cmake --build . --parallel
ninja install

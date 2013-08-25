PLUGINS="/Users/jlaxson/Desktop/X-Plane 10/Resources/plugins/"
SDK=/Users/jlaxson/Downloads/SDK

TARGET=Xsaitekpanels.xpl
HEADERS=$(wildcard *.h)
SOURCES=$(wildcard *.cpp) hid.c
OBJECTS1=$(SOURCES:.cpp=.o)
OBJECTS=$(OBJECTS1:.c=.o)

CC=clang
LD=clang++

CFLAGS=-Wall -I$(SDK)/CHeaders/XPLM/  -I$(SDK)/CHeaders/Widgets/ -DAPL=1 -DXPLM200=1 -arch i386 -arch x86_64 -ggdb
LNFLAGS= -arch x86_64 -arch i386
#LIBS=-L/usr/lib32 #$(PLUGINS)/XPLM.so $(PLUGINS)/XPWidgets.so
LIBS=-F$(SDK)/Libraries/Mac -framework XPLM -framework XPWidgets -bundle -framework CoreFoundation -framework OpenGL -framework IOKit

all: $(TARGET)

.cpp.o:
	$(CC) $(CFLAGS) -c $<

.c.o:
	$(CC) $(CFLAGS) -c $<
	
$(TARGET): $(OBJECTS)
	$(LD) -o $(TARGET) $(LNFLAGS) $(OBJECTS) $(LIBS)

clean:
	rm -f $(OBJECTS) $(TARGET)

install: $(TARGET)
	cp -f $(TARGET) $(PLUGINS)

        

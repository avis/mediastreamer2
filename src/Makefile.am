GITVERSION_FILE=gitversion.h
GITVERSION_FILE_TMP=gitversion.h.tmp

ECHO=/bin/echo

ANDROID_SRC_FILES= \
	msandroid.cpp \
	android-display.c \
	android-display-bad.cpp \
	msandroidvideo.cpp

EXTRA_DIST= winsnd2.c winsnd.c winvideo.c  \
	winvideods.c wincevideods.c dxfilter.h dxfilter.cpp \
	msfileplayer_win.c msfilerec_win.c winsndds.cpp nowebcamCIF.jpg winsnd3.c vfw-missing.h \
	winvideo2.c msjava.c $(ANDROID_SRC_FILES) \
	$(GITVERSION_FILE) yuv2rgb.fs yuv2rgb.vs

BUILT_SOURCES=alldescs.h $(GITVERSION_FILE) yuv2rgb.fs.h yuv2rgb.vs.h

CLEANFILES=alldescs.h filterdescs.txt $(GITVERSION_FILE) yuv2rgb.fs.h yuv2rgb.vs.h

INCLUDES=-I$(top_srcdir)/include/

lib_LTLIBRARIES=libmediastreamer.la

libmediastreamer_la_SOURCES=	mscommon.c    $(GITVERSION_FILE) \
				msfilter.c     \
				msqueue.c      \
				msticker.c     \
				eventqueue.c \
				alaw.c 	       \
				ulaw.c         \
				mssndcard.c    \
				msrtp.c	       \
				dtmfgen.c      \
				ice.c          \
				tee.c          \
				msconf.c       \
				msjoin.c       \
				g711common.h \
				msvolume.c \
				mswebcam.c \
				mtu.c \
				void.c \
				dsptools.c \
				kiss_fft.c  \
				_kiss_fft_guts.h \
				kiss_fft.h \
				kiss_fftr.c \
				kiss_fftr.h \
				equalizer.c \
				chanadapt.c \
				audiomixer.c \
				itc.c \
				tonedetector.c \
				qualityindicator.c \
				g722_decode.c g722.h \
				g722_encode.c \
				msg722.c \
				l16.c \
				audioconference.c \
				bitratedriver.c \
				qosanalyzer.c \
				bitratecontrol.c \
				genericplc.c

#dummy c++ file to force libtool to use c++ linking (because of msdscap-mingw.cc)
nodist_EXTRA_libmediastreamer_la_SOURCES = dummy.cxx

libmediastreamer_la_SOURCES+=audiostream.c


if BUILD_SPEEX
libmediastreamer_la_SOURCES+=msspeex.c speexec.c
endif

if BUILD_GSM
libmediastreamer_la_SOURCES+=gsm.c
endif

if BUILD_G726
libmediastreamer_la_SOURCES+=g726.c
endif

if BUILD_WIN32
libmediastreamer_la_SOURCES+=	winsnd3.c \
				msfileplayer_win.c msfilerec_win.c
else
libmediastreamer_la_SOURCES+=	msfileplayer.c \
				msfilerec.c    
endif

if BUILD_RESAMPLE
libmediastreamer_la_SOURCES+=msresample.c
endif

if BUILD_ALSA
libmediastreamer_la_SOURCES+=alsa.c
endif

if BUILD_OSS
libmediastreamer_la_SOURCES+=oss.c
endif

if BUILD_ARTS
libmediastreamer_la_SOURCES+=arts.c
endif

if BUILD_PORTAUDIO
libmediastreamer_la_SOURCES+=pasnd.c
endif

if BUILD_MACSND
libmediastreamer_la_SOURCES+=macsnd.c
endif

if BUILD_IOSIOUNIT
libmediastreamer_la_SOURCES+=msiounit.m
endif

if BUILD_MACAQSND
libmediastreamer_la_SOURCES+=aqsnd.c
endif

if BUILD_PULSEAUDIO
libmediastreamer_la_SOURCES+=pulseaudio.c
endif

if BUILD_VIDEO

if BUILD_MACOSX
libmediastreamer_la_SOURCES+=qtcapture.m msosxdisplay.m  shaders.c shaders.h opengles_display.c opengles_display.h
nodist_libmediastreamer_la_SOURCES = yuv2rgb.fs.h yuv2rgb.fs.h
endif

if BUILD_IOS
libmediastreamer_la_SOURCES+=scaler.c iosdisplay.m ioscapture.m shaders.c shaders.h opengles_display.c opengles_display.h
nodist_libmediastreamer_la_SOURCES = yuv2rgb.fs.h yuv2rgb.fs.h
endif
if BUILD_V4L1
libmediastreamer_la_SOURCES+=msv4l.c
endif

if BUILD_V4L2
libmediastreamer_la_SOURCES+=msv4l2.c
endif

if BUILD_WIN32
libmediastreamer_la_SOURCES+=msdscap-mingw.cc drawdib-display.c
endif

if BUILD_THEORA
libmediastreamer_la_SOURCES+=theora.c
endif

if BUILD_VP8
libmediastreamer_la_SOURCES+=vp8.c
endif

if BUILD_FFMPEG
libmediastreamer_la_SOURCES+=	videoenc.c \
				videodec.c \
				swscale.h ffmpeg-priv.h \
				h264dec.c \
				jpegwriter.c
endif

if BUILD_SDL
libmediastreamer_la_SOURCES+=videoout.c 
endif

if BUILD_X11_XV
libmediastreamer_la_SOURCES+=x11video.c
endif

if BUILD_X11_GL
libmediastreamer_la_SOURCES+=glxvideo.c opengles_display.c shaders.c
endif

libmediastreamer_la_SOURCES+= rfc2429.h \
				pixconv.c  \
				sizeconv.c \
				msvideo.c \
            msvideo_neon.c \
            msvideo_neon.h \
				rfc3984.c \
				mire.c \
				extdisplay.c \
				layouts.c layouts.h \
				nowebcam.c nowebcam.h 

libmediastreamer_la_SOURCES+=videostream.c

endif




alldescs.h:	Makefile $(libmediastreamer_la_SOURCES)
	builddir=`pwd` && cd $(srcdir) && \
	awk 'BEGIN { FS="[()]" ; }; /^\t*MS_FILTER_DESC_EXPORT/{ printf("%s\n", $$2) } '  > $$builddir/filterdescs.txt $(libmediastreamer_la_SOURCES) && \
	awk 'BEGIN { print("#include \"mediastreamer2/msfilter.h\"\n") } { printf("extern MSFilterDesc %s;\n",$$1) } ' $$builddir/filterdescs.txt > $$builddir/$@ && \
	awk 'BEGIN { print("MSFilterDesc * ms_filter_descs[]={") } { printf("&%s,\n",$$1) } END{ print("NULL\n};\n") } ' $$builddir/filterdescs.txt >> $$builddir/$@


libmediastreamer_la_LIBADD=	$(ORTP_LIBS) \
				$(PORTAUDIO_LIBS) \
				$(ALSA_LIBS) \
				$(ARTS_LIBS) \
				$(LIBPULSE_LIBS) \
				$(SPEEX_LIBS) \
				$(GSM_LIBS) \
				$(LIBV4L1_LIBS) \
				$(LIBV4L2_LIBS) \
				$(SPANDSP_LIBS)
libmediastreamer_la_LDFLAGS= -no-undefined -version-info $(LIBMEDIASTREAMER_SO_VERSION) 

if !BUILD_WIN32
libmediastreamer_la_LDFLAGS+=-rdynamic
endif

if BUILD_VIDEO
libmediastreamer_la_LIBADD+=	$(VIDEO_LIBS) \
								$(THEORA_LIBS) \
								$(GLEW_LIBS)
if BUILD_IOS 
libmediastreamer_la_LDFLAGS+=	-framework CoreGraphics
endif

if BUILD_MACOSX
libmediastreamer_la_LDFLAGS+=	-framework Cocoa -framework OpenGL -framework QuartzCore
endif

if BUILD_WIN32
libmediastreamer_la_LIBADD+=	-lole32 \
				-loleaut32\
				-lwinmm \
				-luuid

endif

endif
if BUILD_WIN32_WCE
libmediastreamer_la_LIBADD+=	-lmmtimer
endif

AM_CFLAGS= $(ORTP_CFLAGS)   \
		$(SPEEX_CFLAGS)  \
		$(GSM_CFLAGS)    \
		$(STRICT_OPTIONS) \
		$(LIBPULSE_CFLAGS) \
		$(SPANDSP_CFLAGS)  \
		$(MSSILK_CFLAGS)

		

AM_CXXFLAGS= $(ORTP_CFLAGS)   \
		$(STRICT_OPTIONS)

DEFS=@DEFS@  -DPACKAGE_PLUGINS_DIR=\"$(PACKAGE_PLUGINS_DIR)\" -DLOCALEDIR=\"$(localedir)\" -DMS2_INTERNAL

if BUILD_VIDEO
AM_CFLAGS+=$(VIDEO_CFLAGS) $(GLEW_CFLAGS)
endif

if BUILD_VP8
AM_CFLAGS+=$(VP8_CFLAGS)
libmediastreamer_la_LIBADD+=$(VP8_LIBS)
endif

AM_OBJCFLAGS=$(AM_CFLAGS)

imgdir=$(datadir)/images/

img_DATA=nowebcamCIF.jpg

make_gitversion_h:
	if test -d $(top_srcdir)/.git ; then \
		$(ECHO) -n "#define GIT_VERSION " > $(GITVERSION_FILE_TMP) &&\
		$(ECHO) \"`cd $(top_srcdir) && git describe`\" >> $(GITVERSION_FILE_TMP) &&\
		if test "`cat $(GITVERSION_FILE_TMP)`" != "`cat $(srcdir)/$(GITVERSION_FILE)`" ; then \
			cp -f $(GITVERSION_FILE_TMP) $(srcdir)/$(GITVERSION_FILE) ; \
		fi \
		&& rm -f $(GITVERSION_FILE_TMP) ;\
	fi
	if ! test -f $(srcdir)/$(GITVERSION_FILE) ; then \
		$(ECHO) -n "#define GIT_VERSION \"unknown\" " > $(srcdir)/$(GITVERSION_FILE) ;\
	fi

$(GITVERSION_FILE):	make_gitversion_h

yuv2rgb.fs.h: yuv2rgb.fs
	builddir=`pwd` && \
	cd $(top_srcdir)/src && \
	xxd -i yuv2rgb.fs | sed s/}\;/,0x00}\;/ > $$builddir/yuv2rgb.fs.h

yuv2rgb.vs.h: yuv2rgb.vs
	builddir=`pwd` && \
	cd $(top_srcdir)/src && \
	xxd -i yuv2rgb.vs | sed s/}\;/,0x00}\;/ > $$builddir/yuv2rgb.vs.h




	


# Notes

- To build docker image: `docker build -t gqrx .`
- To build gr-osmosdr: https://skywavelinux.com/gqrx-spyserver-client.html - Take note that you need to use a forked repo that has support for airspy, airspyhf, and spyserver client: `git clone https://github.com/racerxdl/gr-osmosdr`
- Use https://discourse.myriadrf.org/t/starter-guide-gqrx-gnuradio3-7-soapy-gr-osmo-full-working-ubuntu-18-04/6151 to see which ubuntu packages to install to start the compile. It will be missing a few `apt install libairspy-dev` type packages. You want to make sure that airspy, airspyhf, soapy&, and spyserver are all enabled after doing the cmake. If not, keep `apt install XXX` the lib*-dev packages until it works.
- To start pulseaudio receiving daemon on os x - take note of the auth-anonymous=1 argument passed to the module. This allows for any user to send audio to the server and is required to pass audio from the container: `pulseaudio --load="module-native-protocol-tcp auth-anonymous=1" --exit-idle-time=-1 --daemon`
- To establish pulseaudio tunnel: `ssh -R 24713:localhost:4713 root@localhost -p 2222`
- To start gqrx from within xterm spawned from within Xquartz: `ssh root@localhost -p 2222` then `PULSE_SERVER="tcp:localhost:24713" gqrx`

- The gr-osmosdr.tgz archive contains a compiled version of the plugin with all the soapy, airspy, and spyserver support for the arm64 arch.

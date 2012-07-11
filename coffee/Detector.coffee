
P.Detector = {}


#Gets the user agent, os etc
class Detector

  constructor: () ->
    #Defaults to false

    #Platforms and browsers
    @mobile = false
    @iPhone = false
    @iPad = false
    @iOS = false
    @android = false
    @winphone = false

    @desktop = false
    @chrome = false
    @firefox = false
    @ie = false
    @safari = false
    @opera = false

    #OS
    @windows = false
    @mac = false
    @linux = false

    #Audio
    @canPlayHTML5Audio = false
    @audio = {}
    @preferedAudioFormat = false

    #HTML5 features
    @webworker = false

    #And we run the tests
    @detectWebWorker()
    @detectMobile()

    #If we are not on mobile, dtermine which browser we're using
    if @mobile is false
      @detectBrowser()
      @detectOS()

    @detectAudio()


  #Detects if the client supports audio and if yes, which format
  detectAudio: () ->
    userAudio = document.createElement 'audio'

    if !!userAudio.canPlayType
      @canPlayHTML5Audio = true
      @audio.mp3 = !!(userAudio.canPlayType and userAudio.canPlayType("audio/mpeg;").replace(/no/, ""))
      @audio.ogg = !!(userAudio.canPlayType and userAudio.canPlayType("audio/ogg; codecs=\"vorbis\"").replace(/no/, ""))
      @audio.aac = !!(userAudio.canPlayType and userAudio.canPlayType("audio/mp4; codecs=\"mp4a.40.2\"").replace(/no/, ""))

      #ok we can play html audio, which one should we choose?
      #Only choosing between mp3 and ogg for now.
      #Consider AAC for iOS

      #First choice : if we can only play ogg (like firefox/opera)
      if @audio.ogg and not @audio.mp3
        @preferedAudioFormat = 'ogg'
      #IE/Safari can play mp3 but no ogg
      else if @audio.mp3 and not @audio.ogg
        @preferedAudioFormat = 'mp3'
      #If we have both (chrome)
      else if @audio.mp3 and @audio.ogg
        #I prefer to use ogg
        @preferedAudioFormat = 'ogg'

      #TODO : consider adding a variable @usingSoundManager2 to use this lib if sound doesn't work well

  #Only called if it's not a mobile
  detectBrowser: () ->
    browsers = 
      "chrome":
        subString: "Chrome"
      "firefox":
        subString: "Firefox"
      "safari":
        subString: "Apple"
      "ie":
        subString: "MSIE"

    #opera stores some functions in window
    if window.opera
      return "opera"

    for key of browsers
      if navigator.userAgent.indexOf(browsers[key].subString) isnt -1
        @desktop = true
        if key is "chrome"
          @chrome = true
        else if key is "firefox"
          @firefox = true
        else if key is "safari"
          @safari = true
        else if key is "ie"
          @ie = true


  #Detects if if the client is on a mobile platform
  detectMobile: () ->
    platforms = 
      "iphone":
        subString: "iPhone"
      "ipad":
        subString: "iPad"
      "android":
        subString: "Android"
      "winphone":
        subString: "Windows Phone"

    found = false

    for key of platforms
      if navigator.userAgent.indexOf(platforms[key].subString) isnt -1
        @mobile = true
        console.log key
        if key is "iphone"
          @iPhone = true
          @iOS = true
        else if key is "ipad"
          @iPad = true
          @iOS = true
        else if key is "android"
          @android = true
        else if key is "winphone"
          @winphone = true


  detectOS: () ->
    os =
      "windows":
        subString: "Win"
      "mac":
        subString: "Mac"
      "linux":
        subString: "Linux"

    for key of os
      if navigator.userAgent.indexOf(os[key].subString) isnt -1
        if key is "windows"
          @windows = true
        else if key is "mac"
          @mac = true
        else if key is "linux"
          @linux = true


  detectWebWorker: () ->
    @webworker = !!window.Worker


P.Detector = Detector
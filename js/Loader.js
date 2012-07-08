// Generated by CoffeeScript 1.3.3
(function() {
  var Loader,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  P.Loader = {};

  Loader = (function() {
    var _canPlay, _imagesExtensions, _soundsExtensions;

    _imagesExtensions = ['png', 'jpeg', 'jpg'];

    _soundsExtensions = ['ogg', 'mp3'];

    _canPlay = [];

    function Loader(game) {
      this.game = game;
      this.totalToLoad = this.game.assets.length;
      this.loaded = 0;
      this.images = {};
      this.sounds = {};
      P.Util.addEventHandling(this);
      this.on("loaded", this.eventFileLoaded);
    }

    Loader.prototype._detectAudioFormat = function() {
      var userAudio;
      userAudio = document.createElement('audio');
      if (!!userAudio.canPlayType) {
        if ("" !== userAudio.canPlayType('audio/mpeg;')) {
          _canPlay.push("mp3");
        }
        if ("" !== userAudio.canPlayType('audio/ogg;')) {
          return _canPlay.push("ogg");
        }
      }
    };

    Loader.prototype.eventFileLoaded = function() {
      this.loaded++;
      return this.draw();
    };

    Loader.prototype._load = function() {
      var couldntLoad, extension, file, name, _i, _len, _ref;
      this._detectAudioFormat();
      couldntLoad = [];
      _ref = this.game.assets;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        file = _ref[_i];
        extension = file.substr(file.lastIndexOf(".") + 1).toLowerCase();
        name = file.substr(file.lastIndexOf("/") + 1).toLowerCase();
        if (__indexOf.call(_imagesExtensions, extension) >= 0) {
          if (!this.images[name]) {
            this.images[name] = this._loadImage(file);
            this.fire("loaded");
          }
        } else if (__indexOf.call(_soundsExtensions, extension) >= 0) {
          if (__indexOf.call(_canPlay, extension) >= 0 && !this.sounds[name]) {
            this.sounds[name] = this._loadSound(file);
            this.fire("loaded");
          } else {
            couldntLoad.push(file);
          }
        } else {
          couldntLoad.push(file);
        }
      }
      if (couldntLoad.length > 0) {
        return couldntLoad;
      }
    };

    Loader.prototype._loadSound = function(file) {
      var sound;
      sound = new Audio();
      sound.preload = "auto";
      sound.volume = 1;
      sound.src = file;
      return sound;
    };

    Loader.prototype._loadImage = function(file) {
      var image;
      image = new Image();
      image.src = file;
      return image;
    };

    Loader.prototype.draw = function() {
      var percentage;
      percentage = Math.round((this.loaded / this.totalToLoad) * 100) + " %";
      P.canvas.clear();
      P.canvas.context.fillStyle = "#00f";
      return P.canvas.context.fillText(percentage, P.canvas.centerX, P.canvas.centerY);
    };

    return Loader;

  })();

  P.Loader = Loader;

}).call(this);

var hema = hema || {};
hema.Exchanges = {};

hema.Exchanges.Timer = function(startButtonSelector, secondsInputSelector) {
  this.$startButton = $(startButtonSelector);
  this.$secondsInput = $(secondsInputSelector);
  this.timerOn = false;
};

hema.Exchanges.Timer.prototype = {
  initialize: function() {
    this.$startButton.on('click', this.toggleTimer.bind(this));
  },

  toggleTimer: function(event) {
    event.preventDefault();

    if (this.timerOn) {
      this.timerOn = false;
      this.$startButton.text('Start Timer');
    } else {
      this.timerOn = true;
      this.startTimer();
      this.$startButton.text('Stop Timer');
    }
  },

  startTimer: function() {
    var that = this;

    setTimeout(function() {
      that.addSecond();
    }, 1000);
  },

  addSecond: function() {
    if (this.timerOn) {
      var seconds = Number(this.$secondsInput.val());
      this.$secondsInput.val(seconds + 1);
      this.startTimer();
    }
  }
};

$(function() {
  var timer = new hema.Exchanges.Timer('.exchange-new-start-stop-button', '.exchange-new-seconds-input');
  timer.initialize();
});
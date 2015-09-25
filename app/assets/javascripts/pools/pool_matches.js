var hema = hema || {};
hema.Pools = {};

hema.Pools.PoolMatches = function(sortableMatchesSelector, saveButtonSelector,
  alertSelector, matchSelector) {
  this.$sortableMatches = $(sortableMatchesSelector);
  this.$saveButton = $(saveButtonSelector);
  this.matchSelector = matchSelector;
  this.$alert = $(alertSelector);
  this.savePath = this.$saveButton.data('path');
  this.matchSaveClick = this.matchSaveClick.bind(this);
  this.handleResponse =  this.handleResponse.bind(this);
  this.handleError = this.handleError.bind(this);
};

hema.Pools.PoolMatches.prototype = {
  init: function() {
    this.oldIndexMatches = this.payload().matches;
    this.sortable();
    this.listen();
  },

  sortable: function() {
    this.$sortableMatches.sortable();
  },

  listen: function() {
    this.$saveButton.on('click', this.matchSaveClick);
  },

  matchSaveClick: function(event) {
    event.preventDefault();
    this.clearMessages();
    var payload = this.payload();

    if (this.sameIndex(payload.matches)) {
      return;
    }

    payload = this.cleanPayload(payload);

    $.ajax({
      url: this.savePath,
      method: 'POST',
      data: payload,
      error: this.handleError,
      success: this.handleResponse
    });
  },

  cleanPayload: function(payload) {
    for (var match in this.oldIndexMatches) {
      if (this.oldIndexMatches[match] === payload.matches[match]) {
        delete payload.matches[match]
      }
    }

    return payload;
  },

  sameIndex: function(matches) {
    for (var match in this.oldIndexMatches) {
      if (this.oldIndexMatches[match] !== matches[match]) {
        return false;
      }
    }

    return true;
  },

  clearMessages: function() {
    this.$alert.addClass('alert-hidden');
  },

  handleResponse: function(data) {
    this.oldIndexMatches = this.payload().matches;
    this.$alert.text(data.message);
    this.$alert.removeClass('alert-hidden');
  },

  handleError: function() {
    this.$alert.text('Something went wrong. Please, refresh the page.');
    this.$alert.removeClass('alert-hidden');
  },

  payload: function() {
    var $matches = $(this.matchSelector);
    var payload = {
      matches: {}
    };

    $matches.each(function(index, element) {
      payload.matches[element.dataset.matchId] = index + 1;
    });

    return payload;
  }
};

$(function() {
  var poolMatches = new hema.Pools.PoolMatches('.pool-matches-sortable',
    '.pool-matches-save', '.pool-matches-alert', '.pool-matches-match');
  poolMatches.init();
});

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

    $.ajax({
      url: this.savePath,
      method: 'POST',
      data: this.payload(),
      error: this.handleError,
      success: this.handleResponse
    });
  },

  clearMessages: function() {
    this.$alert.addClass('alert-hidden');
  },

  handleResponse: function(data) {
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
      matches: []
    };

    $matches.each(function(index, element) {
      payload.matches.push({
        index: index + 1,
        match_id: element.dataset.matchId
      });
    });

    return payload;
  }
};

$(function() {
  var poolMatches = new hema.Pools.PoolMatches('.pool-matches-sortable',
    '.pool-matches-save', '.pool-matches-alert', '.pool-matches-match');
  poolMatches.init();
});

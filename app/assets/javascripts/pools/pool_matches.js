var hema = hema || {};
hema.Pools = {};

hema.Pools.PoolMatches = function(sortableMatchesSelector, saveButtonSelector,
  alertSelector, matchSelector) {
  this.$sortableMatches = $(sortableMatchesSelector);
  this.$saveButton = $(saveButtonSelector);
  this.$matches = $(matchSelector);
  this.$alert = $(alertSelector);
  this.matchSaveClick = this.matchSaveClick.bind(this);
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
  }
};

$(function() {
  var poolMatches = new hema.Pools.PoolMatches('.pool-matches-sortable',
    '.pool-matches-save', 'pool-matches-alert', '.pool-matches-match');
  poolMatches.init();
});

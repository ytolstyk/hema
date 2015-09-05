var hema = hema || {};
hema.Tournaments = hema.Tournaments || {};

hema.Tournaments.Pools = function(poolsSelector, fightersSelector, saveSelector, alertSelector) {
  this.$pools = $(poolsSelector);
  this.$fightersSelector = $(fightersSelector);
  this.$saveButton = $(saveSelector);
  this.$alert = $(alertSelector);
  this.sortable(fightersSelector);
  this.savePath = this.$saveButton.data('path');
  this.assignListeners();
};

hema.Tournaments.Pools.prototype.sortable = function(fightersSelector) {
  this.$fightersSelector.sortable({
    connectWith: fightersSelector
  }).disableSelection();
};

hema.Tournaments.Pools.prototype.assignListeners = function() {
  this.$saveButton.on('click', this.savePools.bind(this));
};

hema.Tournaments.Pools.prototype.savePools = function(evt) {
  evt.preventDefault();
  this.clearMessages();

  $.ajax({
    url: this.savePath,
    method: 'POST',
    data: this.payload(),
    error: this.handleResponse.bind(this),
    success: this.handleResponse.bind(this)
  });
};

hema.Tournaments.Pools.prototype.payload = function() {
  var payload = {};
  payload.pools = [];
  var pools = this.$pools.find('.tournament-pools-item');
  $.each(pools, function(idx, pool) {
    var $pool = $(pool);
    var poolObject = { id: $pool.data('pool') };
    poolObject.fighters = [];
    var $fighters = $($pool.find('.tournament-pools-fighter-item'));
    $.each($fighters, function(idx, fighter) {
      poolObject.fighters.push($(fighter).data('fighter'));
    });
    payload.pools.push(poolObject);
  });

  return payload;
};

hema.Tournaments.Pools.prototype.handleResponse = function(data) {
  this.$alert.text(data.message);
  this.$alert.removeClass('alert-hidden');
};

hema.Tournaments.Pools.prototype.clearMessages = function() {
  this.$alert.addClass('alert-hidden');
};

$(function() {
  var pools = new hema.Tournaments.Pools('.tournament-pools-list', '.tournament-pool-fighters-sortable',
    '.save-pools-button', '.tournament-pools-alert');
});

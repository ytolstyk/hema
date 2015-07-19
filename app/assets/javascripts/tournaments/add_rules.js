var hema = hema || {};
hema.Tournaments = hema.Tournaments || {};

hema.Tournaments.addRules = function(submitSelector, addMoreSelector, ruleSelector, rulesFormSelector, removeRuleSelector) {
  this.$submitButton = $(submitSelector);
  this.$addMoreLink = $(addMoreSelector);
  this.ruleSelector = ruleSelector;
  this.$rulesForm = $(rulesFormSelector);
  this.submitPath = this.$rulesForm.prop('action');
  this.removeRuleSelector = removeRuleSelector;
  this.$newRule = $($(this.ruleSelector)[0]).clone();
  this.$formAlerts = $(this.$rulesForm.find('.tournaments-form-alert'));
};

hema.Tournaments.addRules.prototype.initialize = function() {
  this.addListeners();
};

hema.Tournaments.addRules.prototype.addListeners = function() {
  var removeRule = $(this.removeRuleSelector);
  this.$submitButton.on('click', this.sendForm.bind(this));
  this.$rulesForm.on('submit', this.submitForm.bind(this));
  this.$addMoreLink.on('click', this.addMore.bind(this));
  removeRule.on('click', this.removeRule.bind(this));
};

hema.Tournaments.addRules.prototype.sendForm = function(event) {
  event.preventDefault();
  this.clearMessages();

  $.ajax({
    url: this.submitPath,
    method: 'POST',
    data: this.payload(),
    error: this.handleError.bind(this),
    success: this.handleSuccess.bind(this)
  })
};

hema.Tournaments.addRules.prototype.clearMessages = function() {
  $.each(this.$formAlerts, function(index, alert) {
    $(alert).text('').addClass('tournaments-form-alert-hidden');
  });
};

hema.Tournaments.addRules.prototype.submitForm = function(event) {
  event.preventDefault();
};

hema.Tournaments.addRules.prototype.addMore = function(event) {
  event.preventDefault();
  this.clearMessages();
  var $ruleClone = this.$newRule.clone();
  this.$addMoreLink.before($ruleClone);
  $ruleClone.find(this.removeRuleSelector).on('click', this.removeRule.bind(this));
};

hema.Tournaments.addRules.prototype.removeRule = function(event) {
  event.preventDefault();
  this.clearMessages();
  if ($(this.ruleSelector).length < 2) {
    return;
  }

  var $link = $(event.currentTarget);
  $link.parent().remove();
};

hema.Tournaments.addRules.prototype.payload = function() {
  var payload = { scores: [] };
  $.each($(this.ruleSelector), function(index, rule) {
    payload.scores.push({ target: $($(rule).find('.tournament-rule-target option:selected')).val(),
                         points: $($(rule).find('.tournament-rule-score')).val() });
  });

  return payload;
};

hema.Tournaments.addRules.prototype.handleSuccess = function(data) {
  if (data.success !== true) {
    this.handleError();
    return;
  }

  var $alert = $(this.$formAlerts.filter('.alert-success'));
  $alert.text("Saved!").removeClass('tournaments-form-alert-hidden');
};

hema.Tournaments.addRules.prototype.handleError = function(data) {
  var $alert = $(this.$formAlerts.filter('.alert-danger'));
  $alert.text("There was a problem saving the info. Refresh the page and try again.").removeClass('tournaments-form-alert-hidden');
};

$(function() {
  var rules = new hema.Tournaments.addRules('.tournaments-submit-rules-button',
    '.tournaments-rules-add-more', '.tournament-rule', '.tournaments-add-rules-form',
    '.tournament-rule-remove');
  rules.initialize();
});
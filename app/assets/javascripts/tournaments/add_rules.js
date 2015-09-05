var hema = hema || {};
hema.Tournaments = hema.Tournaments || {};

hema.Tournaments.AddRules = function(submitSelector, addMoreSelector, ruleTemplateSelector, rulesFormSelector,
  removeRuleSelector, ruleSelector) {
  this.$submitButton = $(submitSelector);
  this.$addMoreLink = $(addMoreSelector);
  this.ruleSelector = ruleSelector;
  this.$rulesForm = $(rulesFormSelector);
  this.submitPath = this.$rulesForm.prop('action');
  this.removeRuleSelector = removeRuleSelector;
  this.newRuleTemplate = $(ruleTemplateSelector).html();
  this.$formAlerts = $(this.$rulesForm.find('.tournaments-form-alert'));
};

hema.Tournaments.AddRules.prototype = {
  initialize: function() {
    this.addListeners();
  },

  addListeners: function() {
    var removeRule = $(this.removeRuleSelector);
    this.$submitButton.on('click', this.sendForm.bind(this));
    this.$rulesForm.on('submit', this.submitForm.bind(this));
    this.$addMoreLink.on('click', this.addMore.bind(this));
    removeRule.on('click', this.removeRule.bind(this));
  },

  sendForm: function(event) {
    event.preventDefault();
    this.clearMessages();

    $.ajax({
      url: this.submitPath,
      method: 'POST',
      data: this.payload(),
      error: this.handleError.bind(this),
      success: this.handleSuccess.bind(this)
    });
  },

  clearMessages: function() {
    $.each(this.$formAlerts, function(index, alert) {
      $(alert).text('').addClass('tournaments-form-alert-hidden');
    });
  },

  submitForm: function(event) {
    event.preventDefault();
  },

  addMore: function(event) {
    event.preventDefault();
    this.clearMessages();
    var $ruleClone = $($.parseHTML(this.newRuleTemplate));
    this.$addMoreLink.before($ruleClone);
    $ruleClone.find(this.removeRuleSelector).on('click', this.removeRule.bind(this));
  },

  removeRule: function(event) {
    event.preventDefault();
    this.clearMessages();
    if ($(this.ruleSelector).length < 2) {
      return;
    }

    var $link = $(event.currentTarget);
    $link.parent().remove();
  },

  payload: function() {
    var payload = {
      scores: []
    };
    $.each($(this.ruleSelector), function(index, rule) {
      payload.scores.push({ target: $($(rule).find('.tournament-rule-target option:selected')).val(),
                           points: $($(rule).find('.tournament-rule-score')).val() });
    });

    return payload;
  },

  handleSuccess: function(data) {
    if (data.success !== true) {
      this.handleError();
      return;
    }

    var $alert = $(this.$formAlerts.filter('.alert-success'));
    $alert.text("Saved!").removeClass('tournaments-form-alert-hidden');
  },

  handleError: function(data) {
    var $alert = $(this.$formAlerts.filter('.alert-danger'));
    $alert.text("There was a problem saving the info. Refresh the page and try again.").removeClass('tournaments-form-alert-hidden');
  }
};

$(function() {
  var rules = new hema.Tournaments.AddRules('.tournaments-submit-rules-button',
    '.tournaments-rules-add-more', '.add-rules-new-rule-template', '.tournaments-add-rules-form',
    '.tournament-rule-remove', '.tournament-rule');
  rules.initialize();
});

//= require action_cable

(function() {
    this.App || (this.App = {});
    App.cable = ActionCable.createConsumer();
}).call(this);

App.cable.subscriptions.create({channel: 'TestChannel', test_id: testId, user_id: userId}, {
    received: function(data) {
        // process data
        console.info(data);
        $('#code_result').val($('#code_result').val() + '\n' + data.message);
    }
});
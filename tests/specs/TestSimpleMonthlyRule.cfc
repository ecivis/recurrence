component extends="testbox.system.BaseSpec" {

    function run() {
        describe("The Simple Monthly Rule", function () {

            it("should produce monthly rules properly", function () {
                var smr = new recurrence.models.SimpleMonthlyRule();
                expect(smr.getFrequency()).toBe("monthly");
                smr.setInterval(3);
                smr.setOn(1);
                expect(smr.generateRRule()).toBe("FREQ=MONTHLY;INTERVAL=3;BYMONTHDAY=1");

                smr = new recurrence.models.SimpleMonthlyRule();
                smr.setInterval(1);
                smr.setOnLast(true);
                expect(smr.generateRRule()).toBe("FREQ=MONTHLY;INTERVAL=1;BYMONTHDAY=-1");

                expect(function () {
                    smr = new recurrence.models.SimpleMonthlyRule();
                    smr.setOn(32);
                }).toThrow(type="InvalidValueException");

                expect(function () {
                    smr = new recurrence.models.SimpleMonthlyRule();
                    smr.generateRRule();
                }).toThrow(type="InvalidRecurrenceRuleException");
            });

        });
    }

}
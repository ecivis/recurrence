component extends="testbox.system.BaseSpec" {

    function run() {
        describe("The Simple Weekly Rule", function () {

            it("should produce weekly rules properly", function () {
                var swr = new recurrence.models.SimpleWeeklyRule();
                expect(swr.getFrequency()).toBe("weekly");
                swr.setInterval(1);
                swr.setOnDay("MO");
                expect(swr.generateRRule()).toBe("FREQ=WEEKLY;INTERVAL=1;BYDAY=MO");

                swr = new recurrence.models.SimpleWeeklyRule();
                swr.setInterval(2);
                swr.setOn(2);
                expect(swr.generateRRule()).toBe("FREQ=WEEKLY;INTERVAL=2;BYDAY=TU");

                expect(function () {
                    swr = new recurrence.models.SimpleWeeklyRule();
                    swr.setOnDay("FU");
                }).toThrow(type="InvalidValueException");

                expect(function () {
                    swr = new recurrence.models.SimpleWeeklyRule();
                    swr.setOn(8);
                }).toThrow(type="InvalidValueException");
            });

        });
    }

}
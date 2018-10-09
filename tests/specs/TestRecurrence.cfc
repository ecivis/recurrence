component extends="testbox.system.BaseSpec" {

    function run() {
        describe("The Recurrence Library", function () {

            beforeEach(function () {
                variables.recurrence = new recurrence.models.Recurrence();
            });

            it("should create simple rules", function () {
                var swr = variables.recurrence.createRecurrenceRule("SimpleWeeklyRule");
                expect(swr.getFrequency()).toBe("weekly");
                swr.setInterval(1);
                swr.setOnDay("MO");
                expect(swr.generateRRule()).toBe("FREQ=WEEKLY;INTERVAL=1;BYDAY=MO");

                var smr = variables.recurrence.createRecurrenceRule("SimpleMonthlyRule");
                expect(smr.getFrequency()).toBe("monthly");
                smr.setInterval(3);
                smr.setOn(1);
                expect(smr.generateRRule()).toBe("FREQ=MONTHLY;INTERVAL=3;BYMONTHDAY=1");
            });

            it("should iterate weekly recurrences", function () {
                var start = "20180915";
                var ri = variables.recurrence.createRecurrenceIterator("FREQ=WEEKLY;INTERVAL=1;BYDAY=SA", start);

                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180915");
            });

            it("should iterate weekly recurrences and honor the until datetime", function () {
                var start = "20180901";
                var until = "20180915";
                var ri = variables.recurrence.createRecurrenceIterator("FREQ=WEEKLY;INTERVAL=1;BYDAY=SA", start, until);

                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180901");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180908");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180915");
                expect(ri.hasNext()).toBeFalse();
            });

            it("should iterate weekly recurrences and honor the count bound", function () {
                var start = "20180901";
                var count = 3;
                var ri = variables.recurrence.createRecurrenceIterator(rrule="FREQ=WEEKLY;INTERVAL=1;BYDAY=SA", start=start, count=count);

                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180901");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180908");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180915");
                expect(ri.hasNext()).toBeFalse();
            });

            it("should iterate a rule for the last day of every other month", function () {
                var start = "20180131";
                var count = 6;
                var ri = variables.recurrence.createRecurrenceIterator(rrule="FREQ=MONTHLY;INTERVAL=2;BYMONTHDAY=-1", start=start, count=count);

                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180131");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180331");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180531");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180731");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20180930");
                expect(ri.hasNext()).toBeTrue();
                expect(ri.next()).toBe("20181130");
                expect(ri.hasNext()).toBeFalse();
            });


        });
    }

}
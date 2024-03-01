trigger casePracticingTrigger on Case (before insert) {
    PracticingTrigger.setCaseFields(Trigger.New);
}
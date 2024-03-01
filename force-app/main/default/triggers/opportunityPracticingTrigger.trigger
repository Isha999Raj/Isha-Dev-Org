trigger opportunityPracticingTrigger on Opportunity (before update) {
    PracticingTrigger.updateOpportunityfield(Trigger.New);  
}
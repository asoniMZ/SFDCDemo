public with sharing class OpportunityController {
    ApexPages.StandardController m_controller;

    public OpportunityController(ApexPages.StandardController controller)
    {
        m_controller = controller;
        m_controller.addFields(new List<String>{'SystemModstamp'});
    }

    public ApexPages.PageReference save()
    {
        Opportunity record = (Opportunity) m_controller.getRecord();
        Opportunity dbRecord = [select SystemModstamp from Opportunity where Id=:record.Id];
        if(record.SystemModstamp!=dbRecord.SystemModstamp)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Someone else edited the record'));
            return null;
        }
        return m_controller.save();
    }
}
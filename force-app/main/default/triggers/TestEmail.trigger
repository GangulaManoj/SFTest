trigger TestEmail on Lead (before update) {
    
    for (Lead ld: trigger.new) {
        if (ld.Email != trigger.oldMap.get(ld.id).Email) {
            ld.Email = trigger.oldMap.get(ld.id).Email;
            update ld;
        }
    }
}
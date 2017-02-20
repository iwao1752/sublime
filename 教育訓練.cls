trigger setTrainingHistory on education_training__c (after insert,after update) {
    // Update用の取引先責任者リスト
    List<Contact> ths = new List<Contact>();
    // 取引先責任者取得
    List<Contact> con = [SELECT TrainingHistoryforStaffwin__c FROM Contact
                            WHERE Id IN (SELECT staff__c FROM education_training__c WHERE Id =: Trigger.New)];
    // エデュケーションTraining取得
    // ※取引先責任者リストのIDを条件に取得
    List<education_training__c> education_training_list = [
        SELECT
             Id
            ,result_print__c
            ,staff__c
        FROM
            education_training__c
        WHERE
            staff__c IN: con
            AND (
                Status__c ='支払済'
                OR
                Status__c = '受講済'
            )
        ORDER BY ProgramSort__c
    ];
    // 取引先責任者IDをキーにマップ変数にセット
    Map<Id, List<education_training__c>> education_training_map = new Map<Id, List<education_training__c>>();
    for (education_training__c e : education_training_list) {
        // マップにセットするためのリスト
        List<education_training__c> wkEduList = new List<education_training__c>();

        // マップのキーにセット済みか確認
        if (education_training_map.containsKey(e.Staff__c)) {
            wkEduList = education_training_map.get(e.Staff__c);
        }

        // リストに追加
        wkEduList.add(e);

        // マップに追加
        education_training_map.put(e.Staff__c, wkEduList);
    }

    // 取引先責任者をループしながらMap変数にセットしたeducation_training__cリストを取得。
    // TrainingHistoryforStaffwin__c項目に値をセットして、Update用リストに追加していく。
    for( Contact c : con){
        if (education_training_map.containsKey(c.Id)) {
            List<education_training__c> list = education_training_map.get(c.Id);
            c.TrainingHistoryforStaffwin__c = '';
            for (education_training__c e : list) {
                c.TrainingHistoryforStaffwin__c += e.result_print__c;
            }
            ths.add(c);
        }
    }

    // Update
    update ths;
}
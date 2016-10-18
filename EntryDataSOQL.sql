Select ID, NAME, RECORDTYPEID, LEADSOURCE, STATUS, OWNERID, CREATEDDATE, BAITAI__C, JYUSHOTODOUHUKEN__C, LP_KEIYU__C, MENSETUSHUUGYOUKIBOU__C, WEBKP__C, Ankenkanrino1__c
 FROM Lead
 WHERE
 CreatedDate >= 2016-10-17T09:55:00.000Z
 AND JobPrefecture__c != '東京都'
 AND JobPrefecture__c != '神奈川県'
 AND JobPrefecture__c != '千葉県'
 AND JobPrefecture__c != '埼玉県'
 AND JobPrefecture__c != '群馬県'
 AND JobPrefecture__c != '茨城県'
 AND JobPrefecture__c != '山梨県'
 AND LEADSOURCE != '友人紹介'
 AND Recordtype.Name != 'セミナー申込'
 AND CreatedBy.username = 'sf-admin@supernurse.co.jp'
 AND pi__created_date__c = null
 AND ( RecordType.Name = '面接登録予約' OR Recordtype.Name = '転職サービスエントリー' OR Recordtype.Name = 'プレミアムセレクション')
 ORDER BY CreatedDate
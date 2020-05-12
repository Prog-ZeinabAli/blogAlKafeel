//
//  DateFormatter.swift
//  blog
//
//  Created by turath alanbiaa on 5/11/20.
//  Copyright © 2020 test1. All rights reserved.
//
import UIKit
import Foundation
class DateFormatters {

static let instance = DateFormatters()

    func asDate( date : String) -> String {
        let dateFormatterGet = DateFormatter()
               dateFormatterGet.dateFormat = "yyyy-MM-dd"// HH:mm:ss"

               let dateFormatterPrint = DateFormatter()
               dateFormatterPrint.dateFormat = "MMM dd"//,yyyy"

               if let date = dateFormatterGet.date(from: date) {
               
        
        }//from here everything worksk
        /*
        String convTime = null;
        
                String prefix = "منذ ";
                String suffix = " ";
        
                try {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date pasTime = dateFormat.parse(dataDate);
        
                    Date nowTime = new Date();
        
                    long dateDiff = nowTime.getTime() - pasTime.getTime();
        
                    long second = TimeUnit.MILLISECONDS.toSeconds(dateDiff);
                    long minute = TimeUnit.MILLISECONDS.toMinutes(dateDiff);
                    long hour   = TimeUnit.MILLISECONDS.toHours(dateDiff);
                    long day  = TimeUnit.MILLISECONDS.toDays(dateDiff);
        
        
                    if (second < 60) {
                        convTime =" الان ";
                    } else if (minute < 60) {
                        if (minute==1){convTime =prefix+ "دقيقة واحده"+suffix;}
                        else if(minute==2){convTime =prefix+ "دقيقتين "+suffix;}
                        else if(minute>2 && minute<11){convTime =prefix+ minute+" دقائق "+suffix;}
                        else convTime =prefix+ minute+" دقيقة "+suffix;
                    } else if (hour < 24) {
                        if(hour==1){convTime =prefix+ "ساعة واحده"+suffix;}
                        else if(hour==2){convTime =prefix+ "ساعتين"+suffix;}
                        else if(hour>2 && hour<11){convTime =prefix+ hour+" ساعات "+suffix;}
                        else convTime =prefix+ hour+" ساعة"+suffix;
                    } else if (day >= 7) {
                        if (day > 360) {
                            if(day/360 ==1){convTime =prefix + "سنة " + suffix;}
                            else if(day/360 ==2){convTime =prefix + "سنتين " + suffix;}
                            else if(day/360>2 && day/360<11){convTime =prefix+ (day / 360) + " سنوات " + suffix;}
                            else convTime =prefix+ (day / 360) + " سنة " + suffix;
                        } else if (day > 30) {
                            if(day/30 ==1){convTime =prefix+"شهر" + suffix;}
                            else if(day/30 ==2){convTime =prefix+  " شهرين" + suffix;}
                            else if(day/30>2 && day/30<11){convTime =prefix+ (day / 30) + " اشهر " + suffix;}
                            else convTime =prefix+ (day / 30) + " شهر " + suffix;
                        } else {
                            if(day/7==1){ convTime =prefix + "اسبوع " + suffix;}
                            else if(day/7==2){convTime =prefix+ "اسبوعين " + suffix;}
                            else{convTime =prefix+ (day / 7) + " اسابيع " + suffix;}
                        }
                    } else if (day < 7) {
                        if(day==1){convTime =prefix+"يوم "+suffix;}
                        else if(day==2){convTime =prefix+ "يومين "+suffix;}
                        else if(day>2 && day<11){ convTime =prefix+ day+" ايام "+suffix;}
                        else
                        convTime =prefix+ day+" يوم "+suffix;
                    }
        
                } catch (ParseException e) {
                    e.printStackTrace();
                    Log.e("ConvTimeE", e.getMessage());
                }
        
        
        
        */
        //dont delete the rest
         return date
    }
}




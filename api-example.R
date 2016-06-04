key <- "ENTER_EDMUNDS_API_KEY"

r1 <- GET("https://api.edmunds.com/api/vehicle/v2/honda/models",
          query = list(year = "2011", fmt = "json", api_key = key))

content(r1) %>% .$models %>% lapply(function(x) x$name) %>% unlist()

r2 <- GET("https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=100537293&fmt=json", 
         query = list(api_key = key))

r3 <- GET("https://api.edmunds.com/v1/api/tco/usedtruecosttoownbystyleidandzip/101370713/30312?fmt=json",
          query = list(api_key = key))

mileage.vec <- seq(0, 200000, by = 25000)
for(i in 1:length(mileage.vec)){
     condition <- "Clean"
     styleid <- "101370713"
     zip <- "30312"
     #mileage <- "75000"
     r4 <- GET("https://api.edmunds.com/v1/api/tmv/tmvservice/calculateusedtmv", 
               query = list(styleid = styleid, condition = condition,
                            mileage = mileage.vec[i], zip = zip, fmt = "json",
                            api_key = key))
     r4.values[i] <- content(r4)$tmv$nationalBasePrice$usedPrivateParty
}

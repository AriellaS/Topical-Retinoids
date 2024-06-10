import requests

url2021 = "https://data.cms.gov/data-api/v1/dataset/ab29d858-269a-4d97-908f-a26b1cf95f61/data.csv"
url2020 = "https://data.cms.gov/data-api/v1/dataset/016d9d07-83eb-434d-91cb-0e7183d89492/data.csv"
url2019 = "https://data.cms.gov/data-api/v1/dataset/5a27f7a8-c7af-434f-a26c-54db03e22cd1/data.csv"
url2018 = "https://data.cms.gov/data-api/v1/dataset/4861ecfc-a656-4dcd-accb-b9c3b840dfcb/data.csv"
url2017 = "https://data.cms.gov/data-api/v1/dataset/04b93a42-c533-4e5c-8df9-a8f254886cde/data.csv"
url2016 = "https://data.cms.gov/data-api/v1/dataset/0015c60c-af38-4d06-98bd-f058c0abb778/data.csv"
url2015 = "https://data.cms.gov/data-api/v1/dataset/5da1b683-99ea-4734-8216-66ffdcd5e443/data.csv"
url2014 = "https://data.cms.gov/data-api/v1/dataset/2af61f9c-327c-4a23-8b7f-15e38b56e25a/data.csv"
url2013 = "https://data.cms.gov/data-api/v1/dataset/92d814bd-e2fb-48c2-95e7-a4b388a2c4be/data.csv"

urls = [url2021, url2020, url2019, url2018, url2017, url2016, url2015, url2014, url2013]
drugs = ["tretinoin", "adapalene", "tazarotene", "trifarotene", "alitretinoin", "bexarotene"]

for drug in drugs:
    print(drug)
    for i, url in enumerate(urls):
        year = 2021 - i;
        print(year)

        url += "?filter[drug-filer][condition][path]=Gnrc_Name"
        url += "&filter[drug-filer][condition][operator]=%3D"
        url += "&filter[drug-filer][condition][value]=" + drug
        url += "&column=Prscrbr_Type,Brnd_Name,Gnrc_Name,Tot_Clms,Tot_30day_Fills,Tot_Day_Suply,Tot_Drug_Cst"
        res = requests.get(url)

        file = open("rawdata/" + drug + "_" + str(year) + ".csv", 'wb')
        file.write(res.content)
        file.close()



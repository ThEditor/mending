import google.generativeai as genai 
import pathlib
import textwrap

GOOGLE_API_KEY = TOKEN

genai.configure(api_key=GOOGLE_API_KEY)



query = input("input : ")
model = genai.GenerativeModel('gemini-pro')
response = model.generate_content(query)
print(response.text)

import google.generativeai as genai 
import pathlib
import textwrap

def chatbot(query):
    GOOGLE_API_KEY = TOKEN #API KEY GOES HERE

    genai.configure(api_key=GOOGLE_API_KEY)
    model = genai.GenerativeModel('gemini-pro')
    response = model.generate_content(query)
    return response.text
from langchain_openai.chat_models import ChatOpenAI
from langchain.prompts.chat import (
    ChatPromptTemplate,
    SystemMessagePromptTemplate,
    HumanMessagePromptTemplate,
)
from langchain.chains import LLMChain

def generate_travel_recommendations(travel_requests):
    """
    Generate travel recommendations based on user requests
    """
    # create templates
    system_template_travel_agent = """You are travel recommendation agent. Provide a short recommendation based on the user request."""
    system_message_prompt = SystemMessagePromptTemplate.from_template(
        system_template_travel_agent)

    human_template_travel_agent = "{text}"
    human_message_prompt = HumanMessagePromptTemplate.from_template(
        human_template_travel_agent)

    # create full prompt
    chat_prompt = ChatPromptTemplate.from_messages(
        [system_message_prompt, human_message_prompt])

    chain = LLMChain(
        llm=ChatOpenAI(temperature=1),
        prompt=chat_prompt
    )

    recommendations = []
    for travel_request in travel_requests:
        recommendations.append(chain.invoke(travel_request))

    return recommendations

def generate_travel_requests(n=5) -> list[str]:
    """ Generate travel requests
    n: number of requests
    """
    system_template_travel_agent = """Generate one utterance for how someone would travel for a {text}"""
    system_message_prompt = SystemMessagePromptTemplate.from_template(
        system_template_travel_agent)

    # create full prompt
    chat_prompt = ChatPromptTemplate.from_messages(
        [system_message_prompt])

    chain = LLMChain(
        llm=ChatOpenAI(),
        prompt=chat_prompt
    )
    
    results = []
    for _ in range(0, n):
        results.append(chain.invoke("beach vacation"))
    return results

# generate some requests
travel_requests = generate_travel_requests()
# travel_requests = ["I want a beach vacation"]
# print(travel_requests)
# get the recommendations

recommendations = generate_travel_recommendations(travel_requests)
print(recommendations)
%{
	#include<bits/stdc++.h>
	using namespace std;
	map<string, int> mp;
    map<char,int> mb;
	int kwcnt=0,vcnt=0,stcnt=0,istcnt=0,ocnt=0,ccnt=0,lcnt=0;
	set<string> st = {"purnota","opurnota","limitless","hoyto","noyto","boundless","firiye dao","avirvab","noyto hoyto","monovab"};
	void check(string str){
		string t = "";
		vector<string> v;
		for(int i=str.size()-1;i>=0;i--){
			if(str[i]==','){
				reverse(t.begin(),t.end());
				v.push_back(t);
				t = "";
			}
			else if(str[i]==' '){
				break;
			}
			t+=str[i];
		}
		reverse(t.begin(),t.end());
		v.push_back(t);
		for(int i=0;i<v.size();i++){
			string a = v[i];
			if(mp[a]){
				istcnt++;
                cout<<"Error(Declaring) for: "<<a<<"\nStatement No: "<<stcnt+istcnt<<endl;
			} 
			else{
				mp[a]++;
				vcnt++;
				kwcnt++;
			} 
		}
	}
	void conditioncount(){
		ccnt++;
	}
	void loopscount(){
		lcnt++;
	}
	void operatorcount(){
		ocnt++;
	}
	void statementscount(){
		stcnt++;
	}
	void keyscount(string str){
		bool flag = st.count(str);
		if(flag){
			kwcnt++;
		}
		else{
			istcnt++;
			printf("Statement Error\n");
		}
	}
	void soln(){
		for(auto i : st){
			mp[i]++;
		}
	}
    void checkparenthesis(string ch){
        string s=ch;
        if(s[0]==')'){
            if(mb['(']==0){
                istcnt++;
                cout<<"Error(Paranthesis())\nStatement No: "<<stcnt+istcnt<<endl;
            }
            else{
                mb['(']--;
            }
        }
        else if(s[0]=='}'){
            if(mb['{']==0){
                istcnt++;
                cout<<"Error(Paranthesis{}\nStatement No: "<<stcnt+istcnt<<endl;
            }
            else{
                mb['{']--;
            }
        }
        else if(s[0]==']'){
            if(mb['[']==0){
                istcnt++;
                cout<<"Error(Paranthesis{}\nStatement No: "<<stcnt+istcnt<<endl;
            }
            else{
                mb['[']--;
            }
        }
        else{
            mb[s[0]]++;
        }
    }
	void print(){
		cout<<"Variables: "<<vcnt<<endl;
		cout<<"Keywords: "<<kwcnt<<endl;
		cout<<"Operators: "<<ocnt<<endl;
        cout<<"Loops: "<<lcnt<<endl;
        cout<<"statements(Total): "<<stcnt+istcnt<<endl;
        cout<<"Statements(Valid): "<<stcnt-istcnt<<endl;
		cout<<"Statements(Invalid): "<<istcnt<<endl;
        cout<<"Statements(Conditionals): "<<ccnt<<endl; 
	}	
%}

var 						[a-zA-Z][a-zA-Z0-9]*
word 						[a-zA-Z]
num 						[0-9]
principle					"Bank"[ ]++[^\n]+[.h][\n]
syntax						"+"|"-"|"*"|"/"|">"|"<"|"<="|">="|"=="|"!="|"!"|"&&"|"++"|"--"|"="|"^"|"%"|"||"|"|"

%%
{principle}					{ soln();}
"purnota"[ ]+{var}|"opurnota"[ ]+{var}|"monovab"[ ]+{var} 	{
									check(yytext);
								}
"hoyto"						{ keyscount(yytext); conditioncount(); }//if
"noyto"						{ keyscount(yytext); }//else
"noyto hoyto"     			{ keyscount(yytext); }//else if
"limitless"          		{ keyscount(yytext); loopscount(); }//while
"boundless"          		{ keyscount(yytext); loopscount(); }//for
"avirvab"        			{ keyscount(yytext); }//printf
"("                         { checkparenthesis(yytext); }
")"                         { checkparenthesis(yytext); }
"{"                         { checkparenthesis(yytext); }
"}"                         { checkparenthesis(yytext); }
"["                         { checkparenthesis(yytext); }
"]"                         { checkparenthesis(yytext); }
"~"							{ statementscount();}//semiclone 

"%%"(.)*"\n"     			{ printf("Comment(single)\n"); }
[<][!](.*|\n)*[!][>] 		{ printf("Comment(mingle)\n"); }
{syntax} 					{ operatorcount(); }
"firiye dao"				{keyscount(yytext); statementscount(); print();}
.
[ \t\n]+
%%

int yywrap(){
	return 1;
}

int main(){
	yyin=fopen("1907043.txt","r");
	yylex();
	return 0;
}
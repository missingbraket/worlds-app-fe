//
//  QuestionView.swift
//  WorldStudy-v10
//
//  Created by 이서하 on 5/27/25.
//

import SwiftUI

struct QuestionViewMentor: View {
    //    @Binding var isPresented: Bool
    @State private var newQuestionTitle = ""
    @State private var newQuestionContent = ""
    @State private var createQuestionError: String?
    @State private var goToMyPageMenteeView = false //화면이동-메인페이지 생성 후 변경
    
    var token: String = ""
    @ObservedObject var viewModel: QBoardViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 2) {
                
                //화면이동-메인페이지 생성 후 변경
                NavigationLink(destination: MyPageMentee(), isActive: $goToMyPageMenteeView) {
                    EmptyView()
                }
                .hidden()
                
                Text("멘티 질문 보기")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .fontWeight(.ultraLight)
                    .padding(.leading, 25)
                    .padding(.top, 50)
                
                Text("다문화 멘티들이 올린 질문입니다.")
                    .font(.title3)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.leading, 25)
                    .padding(.top, 15)
                
                Text("궁금한 점에 따듯한 답변을 남겨주세요 🌱")
                    .font(.title3)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.leading, 25)
                    .padding(.top, 5)
                
                List(viewModel.questions) { question in
                    NavigationLink(destination: QuestionDetailView(question: question)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(question.title)
                                .font(.headline)
                            Text(question.content)
                                .font(.subheadline)
                                .lineLimit(2)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            //            .navigationTitle("게시판")
            .toolbar {
                //질문 상세(멘토ver)들어가서 >>답변하기Btn<< 추가
                //                ToolbarItem(placement: .navigationBarTrailing) {
                //                    Button("답변하기") {
                //                        showingCreateQuestionSheet = true
                //                    }
                //                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        //화면이동
                        goToMyPageMenteeView = true //화면이동-메인페이지 생성 후 변경
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.gray)
                            .padding(.leading, 15)
                            .frame(width: 20, height: 30)
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchQuestions()
                }
            }
        }
    }
}
    #Preview {
        QuestionViewMentor(viewModel: QBoardViewModel())
        //isPresented: .constant(true), : 프리뷰에서 isPresented를 항상 true로 설정해주는 바인딩
    }

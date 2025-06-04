//
//  MyPageMentee.swift
//  WorldStudy-v10
//
//  Created by 이서하 on 5/23/25.
//

import SwiftUI

struct MyPageMentee: View {
    @State var name: String = "이서하"
    @State var email: String = "123@naver.com"
    @State private var showAlert = false
    @State private var showPasswordAlert = false
    @State private var newPassword: String = ""
    let recentPosts: [Question] = [
        Question(
            id: 1,
            title: "처음 쓴 글",
            content: "내용1",
            createdAt: Date(),
//            deletedAt: nil,
            user: "멘티테스터",
            userId: 1,
            attachments: [
                Attachment(
                    id: 1,
                    fileName: "사진1",
                    fileUrl: "sample",
                    fileSize: 1,
                    fileType: "사진",
                    createdAt: Date(),
                    questionId: 1 )
                    ]),
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 2) {
                Text("멘티")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .fontWeight(.ultraLight)
                    .padding(.leading, 20)
                    .padding(.top, 50)
                
                
                Text("\(name) 님의 마이페이지")
                    .font(.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .padding(.leading, 20)
                    .padding(.vertical, 15)
                
                
                List {
                    Section(header: Text("내 정보")) {
                        HStack {
                            Text("이메일")
                            Spacer()
                            Text("\(email)")
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Text("이름")
                            Spacer()
                            Text("\(name)")
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Text("비밀번호")
                            Spacer()
                            Button(action: {
                                showPasswordAlert = true
                            }) {
                                Text("재설정")
                                    .foregroundColor(.blue)
                            }
                            
//                            .alert("비밀번호 변경", isPresented: $showAlert) {
//                                Button("OK", action:{})
//                            } message: {
//                                Text("새로운 비밀번호를 입력해주세요.")
//                                //비밀번호 재설정 : UIkit(alert+텍스트필드) 추가 해야함
//                            }
                        }
                    }
                    //섹션 안에서만 스크롤 되게 수정해야함
                    Section(header: Text("나의 질문")) {
                        ForEach(recentPosts) { post in
                            NavigationLink(destination: QuestionDetailView(question: post)) {
                                Text(post.title)
                                
                            }
                        }
                    }
                }
                TextFieldWrapper(
                    isPresented: $showPasswordAlert,
                    alert: TextFieldAlert(
                        title: "비밀번호 변경",
                        message: "새 비밀번호를 입력하세요.",
                        placeholder: "4자리 이상 입력하세요.",
                        action: { input in
                            if let input = input {
                                newPassword = input
                                print("입력된 새 비밀번호: \(newPassword)")
                                // 백앤드 이후
                            }
                        }
                    )
                ).frame(width: 0, height: 0)
            }
        }
    }
}

    
#Preview {
    MyPageMentee()
}

// .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

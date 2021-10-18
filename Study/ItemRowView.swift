import SwiftUI

struct ItemRowView: View {
  @EnvironmentObject var store: ItemStore
  let item: Items
  
  var body: some View {
    HStack{
      Text(item.title)
        .onLongPressGesture {
          store.update(itemID: item.id)
        }
      Spacer()
      Text(String(item.number))
      Image(systemName: "trash.circle.fill")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(.red)
        .onTapGesture {
          store.delete(itemID: item.id)
        }
    }
  }
}

struct ItemRowView_Previews: PreviewProvider {
  static var previews: some View {
    ItemRowView(item: ItemMock.itemMock[0])
  }
}

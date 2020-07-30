# defmodule PickInCar.Carts.Router do
#   use PickInCar.BaseAuthRouter
#   alias PickInCar.Carts.CommandBuilder
#   alias PickInCar.Carts.Gateway

#   post "/" do
#     user = conn.assigns[:user]

#     case CommandBuilder.build_add_item_cmd(conn.body_params) do
#       {:ok, cmd} ->
#         {:ok, cart} = Gateway.execute(user.id, cmd)

#         send_json_resp(conn, 201, build_web_cart(cart))

#       {:error, errors} ->
#         send_json_resp(conn, 400, %{error: errors})
#     end
#   end

#   patch "/" do
#     user = conn.assigns[:user]

#     case CommandBuilder.build_update_command(conn.body_params) do
#       {:ok, cmd} ->
#         {:ok, cart} = Gateway.execute(user.id, cmd)
#         send_json_resp(conn, 200, build_web_cart(cart))

#       {:error, errors} ->
#         send_json_resp(conn, 400, %{error: errors})
#     end
#   end

#   get "/validate" do
#     user = conn.assigns[:user]

#     case Gateway.execute(user.id, :valid?) do
#       {:ok, cart} -> send_json_resp(conn, 200, build_cart_summary(cart))
#       {:error, msg} -> send_json_resp(conn, 400, %{errors: msg})
#     end
#   end

#   get "/" do
#     user = conn.assigns[:user]
#     {:ok, cart} = Gateway.execute(user.id, :get_cart)
#     send_json_resp(conn, 200, build_web_cart(cart))
#   end

#   defp sum_total_price(items) do
#     Enum.reduce(items, 0, fn i, acc -> acc + i.total_price end)
#   end

#   def build_cart_summary(cart) do
#     %{
#       total_amount: Enum.reduce(cart.items, 0, fn ci, acc -> acc + ci.total_price end),
#       item_count: Enum.count(cart.items),
#       reserved_slot: cart.reserved_slot
#     }
#   end

#   defp build_web_cart(cart) do
#     item_count = Enum.count(cart.items)
#     total_price = sum_total_price(cart.items)

#     merchants =
#       Enum.group_by(
#         cart.items,
#         fn i ->
#           %{
#             id: i.merchant.id,
#             name: i.merchant.name,
#             sub_total: 0,
#             is_valid: true,
#             minimum_expense: i.merchant.minimum_expense
#           }
#         end,
#         fn i ->
#           %{
#             id: i.id,
#             base_qty: i.base_qty,
#             price: i.price,
#             name: i.name,
#             qty: i.qty,
#             total_price: i.total_price,
#             unit_price: i.unit_price,
#             picture: i.picture,
#             package_qty: i.package_qty,
#             package_type: i.package_type
#           }
#         end
#       )

#     cart_items =
#       merchants
#       |> Map.keys()
#       |> Enum.map(fn m ->
#         Map.put(m, :items, merchants[m])
#       end)
#       |> Enum.map(fn m ->
#         m
#         |> Map.put(:sub_total, sum_total_price(m.items))
#         |> Map.put(:is_valid, sum_total_price(m.items) >= m.minimum_expense)
#       end)

#     Map.put(
#       %{item_count: item_count, total_price: total_price, reserved_slot: cart.reserved_slot},
#       :merchants,
#       cart_items
#     )
#   end
# end

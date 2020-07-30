# defmodule PickInCar.Carts.CommandBuilder do
#   alias PickInCar.Products.ProductCache

#   @add_to_cart_schema %{
#     "type" => "object",
#     "properties" => %{
#       "product_id" => %{"type" => "number"},
#       "qty" => %{"type" => "number"}
#     },
#     "required" => ["product_id"]
#   }

#   @update_qty_schema %{
#     "type" => "object",
#     "properties" => %{
#       "op" => %{
#         "type" => "string",
#         "pattern" => "update_qty"
#       },
#       "payload" => %{
#         "type" => "object",
#         "properties" => %{
#           "product_id" => %{"type" => "number"},
#           "qty" => %{"type" => "number"}
#         }
#       }
#     },
#     "required" => ["op", "payload"]
#   }

#   @remove_item_schema %{
#     "type" => "object",
#     "properties" => %{
#       "op" => %{
#         "type" => "string",
#         "pattern" => "remove_item"
#       },
#       "payload" => %{
#         "type" => "object",
#         "properties" => %{
#           "product_id" => %{"type" => "number"}
#         }
#       }
#     },
#     "required" => ["op", "payload"]
#   }

#   def build_add_item_cmd(payload) do
#     case ExJsonSchema.Validator.validate(@add_to_cart_schema, payload) do
#       :ok ->
#         {:ok, {:add_item, create_add_item_struct(payload)}}

#       {:error, errors} ->
#         {:error, errors}
#     end
#   end

#   def build_update_command(%{"op" => "update_qty"} = payload) do
#     case ExJsonSchema.Validator.validate(@update_qty_schema, payload) do
#       :ok ->
#         {:ok, {:update_qty, create_update_qty_struct(payload)}}

#       {:error, errors} ->
#         {:error, errors}
#     end
#   end

#   def build_update_command(%{"op" => "remove_item"} = payload) do
#     case ExJsonSchema.Validator.validate(@remove_item_schema, payload) do
#       :ok ->
#         {:ok, {:remove_item, create_remove_item_struct(payload)}}

#       {:error, errors} ->
#         {:error, errors}
#     end
#   end

#   defp create_add_item_struct(payload) do
#     {:ok, product} = ProductCache.get(payload["product_id"])
#     Map.put(product, :qty, payload["qty"] || 1)
#   end

#   defp create_update_qty_struct(%{"payload" => payload}) do
#     {:ok, product} = ProductCache.get(payload["product_id"])
#     %{id: product.id, qty: payload["qty"]}
#   end

#   defp create_remove_item_struct(%{"payload" => payload}) do
#     {:ok, product} = ProductCache.get(payload["product_id"])
#     %{id: product.id}
#   end
# end

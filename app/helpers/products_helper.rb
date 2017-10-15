module ProductsHelper
  def boiling_show(boiling)
    if boiling === true
      t('products.boiling.yes')
    else
      t('products.boiling.no')
    end
  end
end
